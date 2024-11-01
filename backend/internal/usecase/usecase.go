package usecase

import (
	"github.com/kurochkinivan/HabitTracker/config"
)

type UseCases struct {
	Auth
}

type UseCasesDependencies struct {
	UserRepo    UserRepository
	VerifRepo   VerificationDataRepository
	RefreshRepo RefreshSessionsRepository
	*config.Config
}

func NewUseCases(d UseCasesDependencies) *UseCases {
	return &UseCases{
		Auth: NewAuthUseCase(d.UserRepo, d.VerifRepo, d.RefreshRepo, d.Config.Auth),
	}
}
