package usecase

import (
	"context"
	"time"

	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	"github.com/sirupsen/logrus"
)

type HabitRepository interface {
	CreateHabitTx(ctx context.Context, habit entity.Habit, notificationTimes []time.Time, scheduleDays []int) error
	GetUserHabits(ctx context.Context, userID string) ([]entity.Habit, error)
	GetDaysOfWeek(ctx context.Context) ([]entity.DayOfWeek, error)
}

type CategoryRepository interface {
	CreateCategory(ctx context.Context, userID string, category *entity.Category) error
	GetCategories(ctx context.Context, userID string) ([]*entity.Category, error)
}

type HabitUseCase struct {
	habitRepo    HabitRepository
	categoryRepo CategoryRepository
}

func NewHabitUseCase(habitRepo HabitRepository, categoryRepo CategoryRepository) *HabitUseCase {
	return &HabitUseCase{
		habitRepo:    habitRepo,
		categoryRepo: categoryRepo,
	}
}

func (h *HabitUseCase) CreateHabit(ctx context.Context, habit entity.Habit, notificationTimes []time.Time, scheduleDays []int) error {
	logrus.WithField("user_id", habit.UserID).Debug("creating habit")
	const op string = "HabitUseCase.CreateHabit"

	err := h.habitRepo.CreateHabitTx(ctx, habit, notificationTimes, scheduleDays)
	if err != nil {
		return apperr.SystemError(err, op, "failed to create habit")
	}

	return nil
}

func (h *HabitUseCase) GetUserHabits(ctx context.Context, userID string) ([]entity.Habit, error) {
	logrus.WithField("user_id", userID).Debug("getting habits")
	const op string = "HabitUseCase.GetHabits"

	habits, err := h.habitRepo.GetUserHabits(ctx, userID)
	if err != nil {
		return nil, apperr.SystemError(err, op, "failed to get habits")
	}

	return habits, nil
}



func (h *HabitUseCase) GetUserCategories(ctx context.Context, userID string) ([]*entity.Category, error) {
	logrus.WithField("user_id", userID).Debug("getting categories")
	const op string = "HabitUseCase.GetCategories"

	categories, err := h.categoryRepo.GetCategories(ctx, userID)
	if err != nil {
		return nil, apperr.SystemError(err, op, "failed to get habits")
	}

	return categories, nil
}

func (h *HabitUseCase) GetDaysOfWeek(ctx context.Context) ([]entity.DayOfWeek, error) {
	logrus.Debug("getting days of week")
	const op string = "HabitUseCase.GetDaysOfWeek"

	days, err := h.habitRepo.GetDaysOfWeek(ctx)
	if err != nil {
		return nil, apperr.SystemError(err, op, "failed to get days of week")
	}

	return days, nil
}

func (h *HabitUseCase) CreateCategory(ctx context.Context, userID string, category *entity.Category) error {
	logrus.WithField("user_id", userID).Debug("creating category")
	const op string = "HabitUseCase.CreateCategory"

	err := h.categoryRepo.CreateCategory(ctx, userID, category)
	if err != nil {
		return apperr.SystemError(err, op, "failed to create category")
	}

	return nil
}
