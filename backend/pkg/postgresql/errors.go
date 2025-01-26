package postgresql

import (
	"fmt"

	"github.com/pkg/errors"
)

var (
	NoRowsAffected = errors.New("no rows affected")
)

func ErrExec(op string, err error) error {
	return errors.Wrap(ParsePgErr(err), fmt.Sprint(op, ": failed to execute query"))
}

func ErrCreateQuery(op string, err error) error {
	return errors.Wrap(ParsePgErr(err), fmt.Sprint(op, ": failed to create sql query"))
}

func ErrDoQuery(op string, err error) error {
	return errors.Wrap(ParsePgErr(err), fmt.Sprint(op, ": failed to do sql query"))
}

func ErrScan(op string, err error) error {
	return errors.Wrap(ParsePgErr(err), fmt.Sprint(op, ": failed to scan from sql query result"))
}
