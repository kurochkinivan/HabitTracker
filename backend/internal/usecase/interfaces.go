package usecase

import (
	"context"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
)

type (
	Auth interface {
		GenerateToken(id string, tokenTTL time.Duration) (string, error)
		ParseToken(accessToken string) (jwt.MapClaims, error)
		hashPassword(password string) string
	}

	UserRepository interface {
		CreateUser(ctx context.Context, user *entity.User) error
		GetUser(ctx context.Context, id string) (entity.User, error)
	}
)
