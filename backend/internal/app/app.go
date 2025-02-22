package app

import (
	"context"
	"fmt"
	"html/template"
	"net"
	"net/http"

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

	logrus.Info("creating repositories...")
	repos := postgresql.NewRepositories(client)

	logrus.Info("creating usecases...")
	useCases := usecase.NewUseCases(&usecase.UseCasesDependencies{
		Repos:  repos,
		TMPLS:  tmpls,
		Config: cfg,
	})

	logrus.Info("creating router...")
	r := v1.NewRouter(cfg.HTTP.BytesLimit, cfg.JWT.JWTSignKey, useCases)

	logrus.Info("starting server...")
	hostport := net.JoinHostPort(cfg.HTTP.Host, cfg.HTTP.Port)
	err = http.ListenAndServe(hostport, r)

	return err
}
