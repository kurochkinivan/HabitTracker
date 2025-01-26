package usecase

import (
	"context"

	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	"github.com/sirupsen/logrus"
)

type HabitUseCase struct {
	habitRepo HabitRepository
}

func NewHabitUseCase(habitRepo HabitRepository) *HabitUseCase {
	return &HabitUseCase{
		habitRepo: habitRepo,
	}
}

func (h *HabitUseCase) CreateHabit(ctx context.Context, habit entity.Habit) error {
	logrus.WithField("user_id", habit.UserID).Debug("creating new habit")
	const op string = "HabitUseCase.CreateHabit"

	err := h.habitRepo.CreateHabit(ctx, habit)
	if err != nil {
		return apperr.SystemError(err, op, "failed to create habit")
	}

	return nil
}

func (h *HabitUseCase) GetUserHabits(ctx context.Context, userID string) ([]entity.Habit, error) {
	logrus.WithField("user_id", userID).Debug("getting all habits")
	const op string = "HabitUseCase.GetHabits"

	habits, err := h.habitRepo.GetUserHabits(ctx, userID)
	if err != nil {
		return nil, apperr.SystemError(err, op, "failed to get all habits")
	}

	return habits, nil
}
