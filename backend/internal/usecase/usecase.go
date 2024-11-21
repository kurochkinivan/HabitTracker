package usecase

import (
	"github.com/kurochkinivan/HabitTracker/config"
)

type UseCases struct {
	Auth
	Habit
}

type UseCasesDependencies struct {
	UserRepo    UserRepository
	VerifRepo   VerificationDataRepository
	RefreshRepo RefreshSessionsRepository
	HabitRepo   HabitRepository
	*config.Config
}

func NewUseCases(d UseCasesDependencies) *UseCases {
	return &UseCases{
		Auth:  NewAuthUseCase(d.UserRepo, d.VerifRepo, d.RefreshRepo, d.Config.Auth),
		Habit: NewHabitUseCase(d.HabitRepo),
	}
}
