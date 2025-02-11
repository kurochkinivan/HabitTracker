package v1

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"

	"github.com/julienschmidt/httprouter"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
)

type habitHandler struct {
	usecase.Habit
	bytesLimit int64
	signingKey string
}

func NewHabitHandler(habit usecase.Habit, bytesLimit int64, signingKey string) Handler {
	return &habitHandler{
		habit,
		bytesLimit,
		signingKey,
	}
}

func (h *habitHandler) Register(r *httprouter.Router) {
	r.GET("/v1/users/:id/habits", errMdw(authMdw(logMdw(h.getHabits), h.signingKey)))
	r.GET("/v1/habits/categories", errMdw(logMdw(h.getCategories)))
	r.GET("/v1/habits/days", errMdw(logMdw(h.getDaysOfWeek)))
	r.POST("/v1/users/:id/habits", errMdw(authMdw(logMdw(h.createHabit), h.signingKey)))
}

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

	resp, err := json.Marshal(habits)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(err)
	}

	w.Write(resp)

	return nil
}

type (
	createRequest struct {
		Name              string      `json:"name"`
		Desc              string      `json:"description"`
		Interval          string      `json:"interval"` // daily, weekly, custom
		CategoryID        int         `json:"category_id"`
		NotificationTimes []time.Time `json:"notification_times"`
		ScheduleDays      []int       `json:"schedule_days"`
	}
)

func (h *habitHandler) createHabit(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.createHabit"

	paramsID := p.ByName("id")
	userID := r.Header.Get("user_id")

	if paramsID != userID {
		return apperr.ErrUnauthorized
	}

	reqData, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(fmt.Errorf("%s: %w", op, err))
	}
	defer r.Body.Close()

	var req createRequest
	err = json.Unmarshal(reqData, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	err = h.CreateHabit(r.Context(), entity.Habit{
		UserID:   userID,
		Name:     req.Name,
		Desc:     req.Desc,
		Category: entity.Category{ID: req.CategoryID},
		Interval: req.Interval,
		IsActive: true,
	}, req.NotificationTimes, req.ScheduleDays)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	w.WriteHeader(http.StatusCreated)

	return nil
}

func (h *habitHandler) getCategories(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.getCategories"

	categories, err := h.GetCategories(r.Context())
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	resp, err := json.Marshal(categories)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	w.Write(resp)

	return nil
}

func (h *habitHandler) getDaysOfWeek(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.getDaysOfWeek"

	days, err := h.GetDaysOfWeek(r.Context())
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	resp, err := json.Marshal(days)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	w.Write(resp)

	return nil
}
