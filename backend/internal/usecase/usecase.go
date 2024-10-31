package usecase

import "time"

type UseCases struct {
	Auth
}

type UseCasesDependencies struct {
	UserRepo      UserRepository
	VerifRepo     VerificationDataRepository
	RefreshRepo   RefreshSessionsRepository
	signingKey    string
	accessTokenTTL      time.Duration
	refreshTokenTTL      time.Duration
	verifCodeTTL  time.Duration
	salt          string
	emailFrom     string
	emailPassword string
}

func NewUseCases(d UseCasesDependencies) *UseCases {
	return &UseCases{
		Auth: NewAuthUseCase(d.UserRepo, d.VerifRepo, d.RefreshRepo, d.signingKey, d.salt, d.accessTokenTTL, d.refreshTokenTTL, d.verifCodeTTL, d.emailFrom, d.emailPassword),
	}
}
