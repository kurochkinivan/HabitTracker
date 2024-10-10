package usecase

import "time"

type UseCases struct {
	Auth
}

type UseCasesDependencies struct {
	Repo       UserRepository
	signingKey string
	tokenTTL   time.Duration
	salt       string
}

func NewUseCases(d UseCasesDependencies) *UseCases {
	return &UseCases{
		Auth: NewAuthUseCase(d.Repo, d.signingKey, d.salt, d.tokenTTL),
	}
}
