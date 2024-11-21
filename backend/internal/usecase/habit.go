package usecase

import (
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

func (h *HabitUseCase) CreateNewHabit(habit entity.Habit) error {
	logrus.WithField("user_id", habit.UserID).Debug("creating new habit")
	const op string = "HabitUseCase.CreateNewHabit"

	err := h.habitRepo.CreateHabit(habit)
	if err != nil {
		return apperr.SystemError(err, op, "failed to create habit")
	}

	return nil 
}