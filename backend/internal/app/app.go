package app

import (
	"context"
	"fmt"

	"github.com/kurochkinivan/HabitTracker/config"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
	"github.com/kurochkinivan/HabitTracker/internal/usecase/repository/postgresql"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

func Run(cfg *config.Config) error {
	cfgp := cfg.PostgreSQL
	pgConfig := psql.NewPgConfig(cfgp.Username, cfgp.Password, cfgp.Host, cfgp.Port, cfgp.Database)

	client, err := psql.NewClient(context.Background(), 5, pgConfig)
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}

	authRepo := postgresql.NewUserRepository(client)
	useCase := usecase.NewAuthUseCase(authRepo, cfg.JWT.JWTSignKey, cfg.Hasher.HasherSalt, cfg.JWT.TokenTTL)

	err = useCase.RegisterUser(context.TODO(), "ivan", "ivan@mail.ru", "12345")
	if err != nil {
		logrus.Fatal(err)
	}

	return nil
}
