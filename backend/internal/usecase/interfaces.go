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
		LoginUser(ctx context.Context, name, email string) (string, error)
		GenerateToken(id string, tokenTTL time.Duration) (string, error)
		ParseToken(accessToken string) (jwt.MapClaims, error)
		hashPassword(password string) string
	}

	UserRepository interface {
		CreateUser(ctx context.Context, user entity.User) error
		GetUserByID(ctx context.Context, id string) (entity.User, error)
		IsUserExists(ctx context.Context, user entity.User) (bool, error)
		AuthenticateUser(ctx context.Context, user entity.User) (entity.User, error)
	}
)
