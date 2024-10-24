package usecase

import (
	"context"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
)

// TODO: think of generate mocks
//go:generate mockgen -source=interfaces.go -destination=./mocks_test.go -package=usecase_test

type (
	Auth interface {
		RegisterUser(ctx context.Context, name, email, password string) error
		LoginUser(ctx context.Context, email, password string) (string, error)
		VerifyEmail(ctx context.Context, email, code string) (string, error)
		SendConfirmationCode(ctx context.Context, email string) error
		GenerateToken(id string, tokenTTL time.Duration) (string, error)
		ParseToken(accessToken string) (jwt.MapClaims, error)
	}

	UserRepository interface {
		GetUserByEmail(ctx context.Context, email string) (entity.User, error)
		UserVerified(ctx context.Context, email string) (bool, error)
		UserExists(ctx context.Context, email string) (bool, error)
		DeleteUser(ctx context.Context, email string) error
		CreateUser(ctx context.Context, user entity.User) error
		AuthenticateUser(ctx context.Context, email, password string) (entity.User, error)
		VerifyEmail(ctx context.Context, email string) error
	}

	VerificationDataRepository interface {
		GetVerificationData(ctx context.Context, email string) (entity.VerificationData, error)
		CreateVerificationData(ctx context.Context, verifData entity.VerificationData) error
		UpdateVerificationDataCode(ctx context.Context, verifData entity.VerificationData) error
		DeleteVerificationData(ctx context.Context, email string) error
		VerificationDataExists(ctx context.Context, email string) (bool, error)
	}
)
