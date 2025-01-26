package postgresql

import (
	"errors"
	"fmt"

	"github.com/jackc/pgx/v5/pgconn"
)

type PgConfig struct {
	Username string
	Password string
	Host     string
	Port     string
	Database string
}

func NewPgConfig(username, password, host, port, database string) *PgConfig {
	return &PgConfig{
		Username: username,
		Password: password,
		Host:     host,
		Port:     port,
		Database: database,
	}
}

func ParsePgErr(err error) error {
	var pgErr *pgconn.PgError
	if errors.As(err, &pgErr) {
		return fmt.Errorf(
			"database error. message:%s, detail:%s, where:%s, sqlstate:%s",
			pgErr.Message,
			pgErr.Detail,
			pgErr.Where,
			pgErr.SQLState(),
		)
	}
	return err
}
