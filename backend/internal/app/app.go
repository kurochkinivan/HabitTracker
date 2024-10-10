package app

import (
	"context"
	"fmt"
	"net/http"

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
	mux := http.NewServeMux()

	authRepo := postgresql.NewUserRepository(client)
	authUseCase := usecase.NewAuthUseCase(authRepo, cfg.JWT.JWTSignKey, cfg.Hasher.HasherSalt, cfg.JWT.TokenTTL)
	authHandler := v1.NewAuthHandler(authUseCase)
	authHandler.Register(mux)


	return http.ListenAndServe(fmt.Sprintf("%s:%s", cfg.HTTP.Host, cfg.HTTP.Port), mux)
}
