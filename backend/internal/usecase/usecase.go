package usecase

import "time"

type UseCases struct {
	Auth
}

type UseCasesDependencies struct {
	UserRepo      UserRepository
	VerifRepo     VerificationDataRepository
	signingKey    string
	tokenTTL      time.Duration
	verifCodeTTL       time.Duration
	salt          string
	emailFrom     string
	emailPassword string
}

func NewUseCases(d UseCasesDependencies) *UseCases {
	return &UseCases{
		Auth: NewAuthUseCase(d.UserRepo, d.VerifRepo, d.signingKey, d.salt, d.tokenTTL, d.verifCodeTTL, d.emailFrom, d.emailPassword),
	}
}
