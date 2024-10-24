package app

import (
	"context"
	"fmt"

	"github.com/kurochkinivan/HabitTracker/config"
	v1 "github.com/kurochkinivan/HabitTracker/internal/controller/http/v1"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
	"github.com/kurochkinivan/HabitTracker/internal/usecase/repository/postgresql"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
)

func Run(cfg *config.Config) error {
	cfgp := cfg.PostgreSQL
	pgConfig := psql.NewPgConfig(cfgp.Username, cfgp.Password, cfgp.Host, cfgp.Port, cfgp.Database)

	client, err := psql.NewClient(context.Background(), 5, pgConfig)
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}

	authRepo := postgresql.NewUserRepository(client)
	verifRepo := postgresql.NewVerificationData(client)
	authUseCase := usecase.NewAuthUseCase(authRepo, verifRepo, cfg.JWT.JWTSignKey, cfg.Hasher.HasherSalt, cfg.JWT.TokenTTL, cfg.Email.VerifCodeTTL, cfg.Email.EmailFrom, cfg.Email.EmailPassword)

	return v1.NewRouter(cfg.HTTP.Host, cfg.HTTP.Port, cfg.HTTP.BytesLimit, authUseCase)
}
