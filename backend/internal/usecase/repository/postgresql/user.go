package postgresql

import (
	"context"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

type userRepository struct {
	client psql.PosgreSQLClient
	qb     sq.StatementBuilderType
}

func NewUserRepository(client *pgxpool.Pool) *userRepository {
	return &userRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

func (r *userRepository) CreateUser(ctx context.Context, user entity.User) error {
	logrus.WithFields(logrus.Fields{"name": user.Name, "email": user.Email}).Trace("creating user")

	sql, args, err := r.qb.
		Insert(TableUsers).
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

func (r *userRepository) GetUserByEmail(ctx context.Context, email string) (entity.User, error) {
	logrus.WithField("email", email).Trace("getting user by email")

	sql, args, err := r.qb.
		Select(
			"id",
			"name",
			"email",
			"password",
			"created_at",
		).
		From(TableUsers).
		Where(sq.Eq{
			"email":       email,
			"is_verified": true,
		}).
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

func (r *userRepository) UserExists(ctx context.Context, email string) (bool, error) {
	logrus.WithFields(logrus.Fields{"email": email}).Trace("checking if user exists")

	sql, args, err := r.qb.
		Select("1").
		Prefix("SELECT EXISTS (").
		From(TableUsers).
		Where(sq.Eq{"email": email}).
		Suffix(")").
		ToSql()
	if err != nil {
		return false, psql.ErrCreateQuery(err)
	}

	var exists bool
	err = r.client.QueryRow(ctx, sql, args...).Scan(&exists)
	if err != nil {
		if err == pgx.ErrNoRows {
			return false, nil
		}
		return false, psql.ErrDoQuery(err)
	}

	return exists, nil
}

func (r *userRepository) UserVerified(ctx context.Context, email string) (bool, error) {
	logrus.WithFields(logrus.Fields{"email": email}).Trace("checking if user is verified")

	sql, args, err := r.qb.
		Select("is_verified").
		From(TableUsers).
		Where(sq.Eq{"email": email}).
		ToSql()
	if err != nil {
		return false, psql.ErrCreateQuery(err)
	}

	var verified bool
	err = r.client.QueryRow(ctx, sql, args...).Scan(&verified)
	if err != nil {
		if err == pgx.ErrNoRows {
			return false, nil
		}
		return false, psql.ErrDoQuery(err)
	}

	return verified, nil
}

func (r *userRepository) DeleteUser(ctx context.Context, email string) error {
	logrus.WithField("email", email).Trace("deleting user")

	sql, args, err := r.qb.
		Delete(TableUsers).
		Where(sq.Eq{"email": email}).
		ToSql()
	if err != nil {
		return psql.ErrCreateQuery(err)
	}

	commTag, err := r.client.Exec(ctx, sql, args...)
	if err != nil {
		return psql.ErrExec(err)
	}

	if commTag.RowsAffected() == 0 {
		return psql.NoRowsAffected
	}

	return nil
}

func (r *userRepository) AuthenticateUser(ctx context.Context, email, password string) (entity.User, error) {
	logrus.WithField("email", email).Trace("authenticating user")

	sql, args, err := r.qb.
		Select(
			"id",
			"name",
			"email",
			"created_at",
		).
		From(TableUsers).
		Where(sq.Eq{
			"email":       email,
			"password":    password,
			"is_verified": true,
		}).
		ToSql()
	if err != nil {
		return entity.User{}, psql.ErrCreateQuery(err)
	}

	var user entity.User
	err = r.client.QueryRow(ctx, sql, args...).Scan(
		&user.ID,
		&user.Name,
		&user.Email,
		&user.CreatedAt,
	)
	if err != nil {
		return entity.User{}, psql.ErrDoQuery(err)
	}

	return user, nil
}

func (r *userRepository) VerifyEmail(ctx context.Context, email string) error {
	logrus.WithField("email", email).Trace("verifying user")

	sql, args, err := r.qb.
		Update(TableUsers).
		Set("is_verified", true).
		Where(sq.Eq{"email": email}).
		ToSql()
	if err != nil {
		return psql.ErrCreateQuery(err)
	}

	commTag, err := r.client.Exec(ctx, sql, args...)
	if err != nil {
		return psql.ErrExec(err)
	}

	if commTag.RowsAffected() == 0 {
		return psql.NoRowsAffected
	}

	return nil
}
