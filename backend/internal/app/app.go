package app

import (
	"context"
	"fmt"

	"github.com/kurochkinivan/HabitTracker/config"
	v1 "github.com/kurochkinivan/HabitTracker/internal/controller/http/v1"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
	"github.com/kurochkinivan/HabitTracker/internal/usecase/repository/postgresql"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

func Run(cfg *config.Config) error {
	cfgp := cfg.PostgreSQL
	pgConfig := psql.NewPgConfig(cfgp.Username, cfgp.Password, cfgp.Host, cfgp.Port, cfgp.Database)

	logrus.Info("connecting to database client...")
	client, err := psql.NewClient(context.Background(), 5, pgConfig)
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}

	logrus.Info("creating repositories and usecases...")
	authRepo := postgresql.NewUserRepository(client)
	verifRepo := postgresql.NewVerificationData(client)
	refreshRepo := postgresql.NewRefreshSessionsRepository(client)
	dependencies := usecase.UseCasesDependencies{
		UserRepo:    authRepo,
		VerifRepo:   verifRepo,
		RefreshRepo: refreshRepo,
		Config:      cfg,
	}
	authUseCase := usecase.NewUseCases(dependencies)


	logrus.Info("starting server...")
	return v1.NewRouter(cfg.HTTP.Host, cfg.HTTP.Port, cfg.HTTP.BytesLimit, cfg.JWT.JWTSignKey, authUseCase)
}
