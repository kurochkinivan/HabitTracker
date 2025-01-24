package app

import (
	"context"
	"fmt"
	"html/template"

	"github.com/kurochkinivan/HabitTracker/config"
	v1 "github.com/kurochkinivan/HabitTracker/internal/controller/http/v1"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
	"github.com/kurochkinivan/HabitTracker/internal/usecase/repository/postgresql"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

func Run(cfg *config.Config, tmpls map[string]*template.Template) error {
	cfgpq := cfg.PostgreSQL
	pgConfig := psql.NewPgConfig(cfgpq.Username, cfgpq.Password, cfgpq.Host, cfgpq.Port, cfgpq.Database)

	logrus.Info("connecting to database client...")
	client, err := psql.NewClient(context.Background(), 5, pgConfig)
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}

	logrus.Info("creating repositories and usecases...")
	authRepo := postgresql.NewUserRepository(client)
	verifRepo := postgresql.NewVerificationData(client)
	refreshRepo := postgresql.NewRefreshSessionsRepository(client)
	habitRepo := postgresql.NewHabitRepository(client)

	dependencies := usecase.UseCasesDependencies{
		UserRepo:    authRepo,
		VerifRepo:   verifRepo,
		RefreshRepo: refreshRepo,
		HabitRepo:   habitRepo,
		TMPLS:       tmpls,
		Config:      cfg,
	}
	authUseCase := usecase.NewUseCases(dependencies)

	logrus.Info("starting server...")
	return v1.NewRouter(cfg.HTTP.Host, cfg.HTTP.Port, cfg.HTTP.BytesLimit, cfg.JWT.JWTSignKey, authUseCase)
}
