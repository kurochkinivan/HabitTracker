package usecase

import (
	"html/template"

	"github.com/kurochkinivan/HabitTracker/config"
	"github.com/kurochkinivan/HabitTracker/internal/usecase/repository/postgresql"
)

type UseCases struct {
	*AuthUseCase
	*HabitUseCase
}

type UseCasesDependencies struct {
	Repos  *postgresql.Repositories
	TMPLS  map[string]*template.Template
	Config *config.Config
}

func NewUseCases(d *UseCasesDependencies) *UseCases {
	return &UseCases{
		AuthUseCase:  NewAuthUseCase(d.Repos.User, d.Repos.VerificationData, d.Repos.RefreshSessions, d.TMPLS, d.Config.Auth),
		HabitUseCase: NewHabitUseCase(d.Repos.Habit, d.Repos.Category),
	}
}
