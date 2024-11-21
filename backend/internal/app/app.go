package app

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/kurochkinivan/HabitTracker/config"
	v1 "github.com/kurochkinivan/HabitTracker/internal/controller/http/v1"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
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
	habitRepo := postgresql.NewHabitRepository(client)

	t1 := time.Date(1, time.January, 1, 20, 15, 0, 0, time.UTC) // 20:15
	t2 := time.Date(1, time.January, 1, 8, 30, 0, 0, time.UTC)  // 08:30
	t3 := time.Date(1, time.January, 1, 12, 45, 0, 0, time.UTC) // 12:45
	times := []time.Time{t1, t2, t3}

	habit := entity.Habit{
		UserID: "c09014c2-0fde-4b04-9b31-df05c9fce66c",
		Name: "Бросить курить",
		Interval: "custom",
		Days: []int{0, 3, 5},
		Notifications: times,
	}
	err = habitRepo.CreateHabit(habit)
	if err != nil {
		log.Fatal(err)
	}

	dependencies := usecase.UseCasesDependencies{
		UserRepo:    authRepo,
		VerifRepo:   verifRepo,
		RefreshRepo: refreshRepo,
		HabitRepo: habitRepo,
		Config:      cfg,
	}
	authUseCase := usecase.NewUseCases(dependencies)


	logrus.Info("starting server...")
	return v1.NewRouter(cfg.HTTP.Host, cfg.HTTP.Port, cfg.HTTP.BytesLimit, cfg.JWT.JWTSignKey, authUseCase)
}
