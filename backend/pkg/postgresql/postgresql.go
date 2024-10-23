package postgresql

import (
	"context"
	"fmt"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/sirupsen/logrus"
)

type PosgreSQLClient interface {
	Exec(ctx context.Context, sql string, arguments ...any) (pgconn.CommandTag, error)
	QueryRow(ctx context.Context, sql string, args ...any) pgx.Row
}

func NewClient(ctx context.Context, maxAttempts int, cfg *PgConfig) (*pgxpool.Pool, error) {
	connString := fmt.Sprintf("postgresql://%s:%s@%s:%s/%s", cfg.Username, cfg.Password, cfg.Host, cfg.Port, cfg.Database)

	pgConfig, err := pgxpool.ParseConfig(connString)
	if err != nil {
		return nil, fmt.Errorf("failed to parse connection string: %w", err)
	}

	pool, err := pgxpool.NewWithConfig(ctx, pgConfig)
	if err != nil {
		return nil, fmt.Errorf("failed to create pool: %w", err)
	}

	err = doWithAttempts(func() error {
		pingErr := pool.Ping(ctx)
		if pingErr != nil {
			logrus.Warn("failed to connect to postgresql, retrying...")
			return pingErr
		}
		return nil
	}, 3*time.Second, maxAttempts)
	if err != nil {
		return nil, fmt.Errorf("all attempts exceeded, failed to connect to postgresql: %w", err)
	}

	return pool, nil
}

func doWithAttempts(f func() error, interval time.Duration, maxAttempts int) error {
	var err error
	for maxAttempts > 0 {
		if err = f(); err != nil {
			time.Sleep(interval)
			maxAttempts--
			continue
		}
		return nil
	}

	return err
}
