package auth

import (
	"context"

	"github.com/kurochkinivan/HabitTracker/internal/entity"
)

type AuthService interface {
	CreateUser(ctx context.Context, user entity.User) error
	GetUser(ctx context.Context, id string) (entity.User, error)
}