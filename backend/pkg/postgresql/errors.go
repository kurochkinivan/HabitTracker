package postgresql

import (
	"github.com/pkg/errors"
)

var (
	NoRowsAffected = errors.New("no rows affected")
)

func ErrExec(err error) error {
	return errors.Wrap(err, "failed to execute query")
}

func ErrCreateQuery(err error) error {
	return errors.Wrap(err, "failed to create sql query")
}

func ErrDoQuery(err error) error {
	return errors.Wrap(err, "failed to do sql query")
}
