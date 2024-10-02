package app

import (
	"context"
	"fmt"

	"github.com/kurochkinivan/HabitTracker/internal/config"
	"github.com/kurochkinivan/HabitTracker/pkg/postgresql"
)

func Run(cfg *config.Config) error {
	cfgp := cfg.PostgreSQL
	pgConfig := postgresql.NewPgConfig(cfgp.Username, cfgp.Password, cfgp.Host, cfgp.Port, cfgp.Database)

	client, err := postgresql.NewClient(context.Background(), 5, pgConfig)
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}

	fmt.Println(client)

	return nil
}
