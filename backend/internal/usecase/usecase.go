package usecase

import (
	"html/template"

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
	TMPLS       map[string]*template.Template
	Config      *config.Config
}

func NewUseCases(d UseCasesDependencies) *UseCases {
	return &UseCases{
		Auth:  NewAuthUseCase(d.UserRepo, d.VerifRepo, d.RefreshRepo, d.TMPLS, d.Config.Auth),
		Habit: NewHabitUseCase(d.HabitRepo),
	}
}
