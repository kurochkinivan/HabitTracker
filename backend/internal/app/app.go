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
	authUseCase := usecase.NewAuthUseCase(authRepo, cfg.JWT.JWTSignKey, cfg.Hasher.HasherSalt, cfg.JWT.TokenTTL)

	err = authUseCase.RegisterUser(context.TODO(), "anatoly", "vanya.kurochkin@mail.ru", "12345")
	if err != nil {
		logrus.WithError(err).Error("failed to register user")
	}

	token, err := authUseCase.LoginUser(context.TODO(), "vanya.kurochkin@mail.ru", "12345")
	if err != nil {
		logrus.WithError(err).Error("failed to login user")
	}

	logrus.Info(token)

	payload, err := authUseCase.ParseToken(token)
	if err != nil {
		logrus.Fatal(err)
	}
	fmt.Println(payload)

	return nil
}
