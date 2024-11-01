package usecase

import (
	"context"

	"github.com/kurochkinivan/HabitTracker/internal/entity"
)

// TODO: think of generate mocks
//go:generate mockgen -source=interfaces.go -destination=./mocks_test.go -package=usecase_test

type (
	Auth interface {
		LoginUser(ctx context.Context, email, password, fingerprint string) (string, string, error)
		RegisterUser(ctx context.Context, name, email, password string) error
		VerifyEmail(ctx context.Context, email, code, fingerprint string) (string, string, error)
		SendConfirmationCode(ctx context.Context, email string) error
	}

	UserRepository interface {
		AuthenticateUser(ctx context.Context, email, password string) (string, error)
		GetUserByEmail(ctx context.Context, email string) (entity.User, error)
		UserVerified(ctx context.Context, email string) (bool, error)
		UserExists(ctx context.Context, email string) (bool, error)
		CreateUser(ctx context.Context, user entity.User) error
		VerifyEmail(ctx context.Context, email string) error
		DeleteUser(ctx context.Context, email string) error
	}

	VerificationDataRepository interface {
		UpdateVerificationDataCode(ctx context.Context, verifData entity.VerificationData) error
		GetVerificationData(ctx context.Context, email string) (entity.VerificationData, error)
		CreateVerificationData(ctx context.Context, verifData entity.VerificationData) error
		VerificationDataExists(ctx context.Context, email string) (bool, error)
		DeleteVerificationData(ctx context.Context, email string) error
	}

	RefreshSessionsRepository interface {
		CreateRefreshSession(ctx context.Context, refreshSession entity.RefreshSession) (string, error)
	}
)
