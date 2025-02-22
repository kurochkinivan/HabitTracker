package v1

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"

	"github.com/julienschmidt/httprouter"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
)

type HabitUseCase interface {
	CreateHabit(ctx context.Context, habit entity.Habit, notificationTimes []time.Time, scheduleDays []int) error
	GetUserHabits(ctx context.Context, userID string) ([]entity.Habit, error)
	CreateCategory(ctx context.Context, userID string, category *entity.Category) error
	GetUserCategories(ctx context.Context, userID string) ([]*entity.Category, error)
	GetDaysOfWeek(ctx context.Context) ([]entity.DayOfWeek, error)
}

type habitHandler struct {
	HabitUseCase
	bytesLimit int64
	signingKey string
}

func NewHabitHandler(habit HabitUseCase, bytesLimit int64, signingKey string) Handler {
	return &habitHandler{
		habit,
		bytesLimit,
		signingKey,
	}
}

func (h *habitHandler) Register(r *httprouter.Router) {
	r.GET("/v1/users/:id/habits", errMdw(authMdw(logMdw(h.getHabits), h.signingKey)))
	r.GET("/v1/habits/days", errMdw(logMdw(h.getDaysOfWeek)))
	r.GET("/v1/users/:id/categories", errMdw(authMdw(logMdw(h.getCategories), h.signingKey)))
	r.POST("/v1/users/:id/habits", errMdw(authMdw(logMdw(h.createHabit), h.signingKey)))
	r.POST("/v1/users/:id/categories", errMdw(authMdw(logMdw(h.createCategory), h.signingKey)))
}

type (
	getHabitsResponse struct {
		ID               int                `json:"id"`
		Name             string             `json:"name"`
		Description      string             `json:"description"`
		Interval         string             `json:"interval"`
		IsActive         bool               `json:"is_active"`
		Popularity_index float64            `json:"popularity_index"`
		Category         string             `json:"category_name"`
		Notifications    []notificationTime `json:"notification_times"`
		Schedules        []string           `json:"schedule_days"`
	}

	notificationTime struct {
		Time     time.Time `json:"time"`
		IsActive bool      `json:"is_active"`
	}
)

func (h *habitHandler) mapHabitsToGetHabitsResponse(habits []entity.Habit) []getHabitsResponse {
	respData := make([]getHabitsResponse, len(habits))
	for i, habit := range habits {
		respData[i] = getHabitsResponse{
			ID:               habit.ID,
			Name:             habit.Name,
			Description:      habit.Desc,
			Interval:         habit.Interval,
			IsActive:         habit.IsActive,
			Popularity_index: habit.PopularityIndex,
			Category:         habit.Category.Name,
			Notifications: func() []notificationTime {
				result := make([]notificationTime, len(habit.Notifications))
				for i, notif := range habit.Notifications {
					result[i] = notificationTime{
						Time:     notif.NotificationTime,
						IsActive: notif.IsActive,
					}
				}
				return result
			}(),
			Schedules: func() []string {
				result := make([]string, len(habit.Schedules))
				for i, schedule := range habit.Schedules {
					result[i] = schedule.Day
				}
				return result
			}(),
		}
	}
	return respData
}

// @Summary		Get list of user's habits
// @Description	Get list of user's habits
// @Tags			habits
// @Param			Authorization	header	string	true	"Authorization header must be set for valid response. It should be in format: Bearer {access_token}"
// @Param			id				path	string	true	"User ID"
// @Produce		json
// @Success		200	{array}		v1.getHabitsResponse	"OK."
// @Failure		400	{object}	apperr.AppError			"Bad Request"
// @Failure		401	{object}	apperr.AppError			"Unauthorized. User does not have access to the habits"
// @Failure		500	{object}	apperr.AppError			"Internal Server Error"
// @Router			/users/{id}/habits [get]
func (h *habitHandler) getHabits(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.getHabits"

	paramsID := p.ByName("id")
	userID := r.Header.Get("user_id")

	if paramsID != userID {
		return apperr.ErrUnauthorized
	}

	habits, err := h.GetUserHabits(r.Context(), paramsID)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	resp, err := json.Marshal(h.mapHabitsToGetHabitsResponse(habits))
	if err != nil {
		return apperr.ErrSerializeData.WithErr(err)
	}

	w.Write(resp)

	return nil
}

type (
	createHabitReq struct {
		Name              string      `json:"name"`
		Desc              string      `json:"description"`
		Interval          string      `json:"interval" enums:"daily,weekly,custom"` // daily, weekly, custom
		CategoryID        int         `json:"category_id"`
		NotificationTimes []time.Time `json:"notification_times"`
		ScheduleDays      []int       `json:"schedule_days"`
	}
)

func mapCreateHabitRequestToHabit(userID string, req createHabitReq) entity.Habit {
	return entity.Habit{
		UserID:   userID,
		Name:     req.Name,
		Desc:     req.Desc,
		Category: entity.Category{ID: req.CategoryID},
		Interval: req.Interval,
		IsActive: true,
	}
}

// @Summary		Create habit for user
// @Description	Create habit for user
// @Tags			habits
// @Param			Authorization	header	string	true	"Authorization header must be set for valid response. It should be in format: Bearer {access_token}"
// @Accept			json
//
// @Param			request		body	v1.createHabitReq	true	"create habit request parameters"
// @Param			interval	body	string				true	"Interval type"	Enums(daily, weekly, custom)
//
// @Success		201			"Created"
// @Failure		400			{object}	apperr.AppError	"Bad Request"
// @Failure		401			{object}	apperr.AppError	"Unauthorized. User does not have access to the habits"
// @Failure		500			{object}	apperr.AppError	"Internal Server Error"
// @Router			/users/{id}/habits [post]
func (h *habitHandler) createHabit(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.createHabit"

	paramsID := p.ByName("id")
	userID := r.Header.Get("user_id")

	if paramsID != userID {
		return apperr.ErrUnauthorized
	}

	data, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(fmt.Errorf("%s: %w", op, err))
	}
	defer r.Body.Close()

	var req createHabitReq
	err = json.Unmarshal(data, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	err = h.CreateHabit(r.Context(), mapCreateHabitRequestToHabit(userID, req), req.NotificationTimes, req.ScheduleDays)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	w.WriteHeader(http.StatusCreated)

	return nil
}

type (
	getCategoriesResponse struct {
		ID   int    `json:"id"`
		Name string `json:"name"`
	}
)

func mapCategoriesToGetCategoriesResponse(categories []*entity.Category) []getCategoriesResponse {
	respData := make([]getCategoriesResponse, len(categories))
	for i, category := range categories {
		respData[i] = getCategoriesResponse{
			ID:   category.ID,
			Name: category.Name,
		}
	}
	return respData
}

// @Summary		Get user's categories
// @Description	Get user's categories
// @Tags			categories
// @Produce		json
// @Success		200	{array}		v1.getCategoriesResponse	"OK."
// @Failure		400	{object}	apperr.AppError				"Bad Request"
// @Failure		401	{object}	apperr.AppError				"Unauthorized. User does not have access to the habits"
// @Failure		500	{object}	apperr.AppError				"Internal Server Error"
// @Router			/users/{id}/categories [get]
func (h *habitHandler) getCategories(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.getCategories"

	paramsID := p.ByName("id")
	userID := r.Header.Get("user_id")

	if paramsID != userID {
		return apperr.ErrUnauthorized
	}

	categories, err := h.GetUserCategories(r.Context(), userID)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	resp, err := json.Marshal(mapCategoriesToGetCategoriesResponse(categories))
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	w.Write(resp)

	return nil
}

type (
	getDaysResponse struct {
		ID   int    `json:"id"`
		Name string `json:"name"`
	}
)

func mapDaysToGetDaysResponse(days []entity.DayOfWeek) []getDaysResponse {
	respData := make([]getDaysResponse, len(days))
	for i, day := range days {
		respData[i] = getDaysResponse{
			ID:   day.ID,
			Name: day.Name,
		}
	}
	return respData
}

// @Summary		Get week days
// @Description	Get week days
// @Tags			habits
// @Produce		json
// @Success		200	{array}		v1.getDaysResponse	"OK."
// @Failure		400	{object}	apperr.AppError		"Bad Request"
// @Failure		401	{object}	apperr.AppError		"Unauthorized. User does not have access to the habits"
// @Failure		500	{object}	apperr.AppError		"Internal Server Error"
// @Router			/habits/days [get]
func (h *habitHandler) getDaysOfWeek(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.getDaysOfWeek"

	days, err := h.GetDaysOfWeek(r.Context())
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	resp, err := json.Marshal(mapDaysToGetDaysResponse(days))
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	w.Write(resp)

	return nil
}

type (
	createCategoryRequest struct {
		Name string `json:"name"`
	}
)

func mapCreateCategoryReqToCategory(req createCategoryRequest) *entity.Category {
	return &entity.Category{
		Name: req.Name,
	}
}

// @Summary		Create category for user
// @Description	Create category for user
// @Tags			categories
// @Param			Authorization	header	string	true	"Authorization header must be set for valid response. It should be in format: Bearer {access_token}"
// @Accept			json
//
// @Param			request		body	v1.createCategoryRequest	true	"create category request parameters"
//
// @Success		201			"Created"
// @Failure		400			{object}	apperr.AppError	"Bad Request"
// @Failure		401			{object}	apperr.AppError	"Unauthorized. User does not have access to the categories"
// @Failure		500			{object}	apperr.AppError	"Internal Server Error"
// @Router			/users/{id}/categories [post]
func (h *habitHandler) createCategory(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.createCategory"

	paramsID := p.ByName("id")
	userID := r.Header.Get("user_id")

	if paramsID != userID {
		return apperr.ErrUnauthorized
	}

	data, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(fmt.Errorf("%s: %w", op, err))
	}
	defer r.Body.Close()

	var req createCategoryRequest
	err = json.Unmarshal(data, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	err = h.CreateCategory(r.Context(), userID, mapCreateCategoryReqToCategory(req))
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	w.WriteHeader(http.StatusCreated)

	return nil
}
