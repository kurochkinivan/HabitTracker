package postgresql

import (
	"context"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

type PosgreSQLClient interface {
	Exec(ctx context.Context, sql string, arguments ...any) (pgconn.CommandTag, error)
	QueryRow(ctx context.Context, sql string, args ...any) pgx.Row
}

type userRepository struct {
	client PosgreSQLClient
	qb     sq.StatementBuilderType
}

func NewUserRepository(client *pgxpool.Pool) *userRepository {
	return &userRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

func (r *userRepository) CreateUser(ctx context.Context, user *entity.User) error {
	logrus.WithFields(logrus.Fields{"name": user.Name, "email": user.Email}).Trace("creating user")

	sql, args, err := r.qb.
		Insert(usersTable).
		Columns(
			"name",
			"email",
			"password",
		).
		Values(
			user.Name,
			user.Email,
			user.Password,
		).
		ToSql()
	if err != nil {
		return psql.ErrCreateQuery(err)
	}

	commtag, err := r.client.Exec(ctx, sql, args...)
	if err != nil {
		return psql.ErrExec(err)
	}

	if commtag.RowsAffected() == 0 {
		return psql.NoRowsAffected
	}

	return nil
}

func (r *userRepository) GetUser(ctx context.Context, id string) (entity.User, error) {
	logrus.WithField("id", id).Trace("getting user")

	sql, args, err := r.qb.
		Select(
			"id",
			"name",
			"email",
			"password",
			"created_at",
		).
		From(usersTable).
		Where(sq.Eq{"id": id}).
		ToSql()
	if err != nil {
		return entity.User{}, psql.ErrCreateQuery(err)
	}

	var user entity.User
	err = r.client.QueryRow(ctx, sql, args...).Scan(
		&user.ID,
		&user.Name,
		&user.Email,
		&user.Password,
		&user.CreatedAt,
	)
	if err != nil {
		return entity.User{}, psql.ErrDoQuery(err)
	}

	return user, nil
}
