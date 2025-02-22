package postgresql

import (
	"context"
	"errors"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

type UserRepository struct {
	client *pgxpool.Pool
	qb     sq.StatementBuilderType
}


func NewUserRepository(client *pgxpool.Pool) *UserRepository {
	return &UserRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

func (r *UserRepository) CreateUser(ctx context.Context, user entity.User) error {
	logrus.WithFields(logrus.Fields{"name": user.Name, "email": user.Email}).Trace("creating user")
	const op string = "UserRepository.CreateUser"

	sql, args, err := r.qb.
		Insert(TableUsersSc).
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
		return psql.ErrCreateQuery(op, err)
	}

	commtag, err := r.client.Exec(ctx, sql, args...)
	if err != nil {
		return psql.ErrExec(op, err)
	}

	if commtag.RowsAffected() == 0 {
		return psql.NoRowsAffected
	}

	return nil
}

func (r *UserRepository) GetUserByEmail(ctx context.Context, email string) (entity.User, error) {
	logrus.WithField("email", email).Trace("getting user by email")
	const op string = "UserRepository.GetUserByEmail"

	sql, args, err := r.qb.
		Select(
			"id",
			"name",
			"email",
			"password",
			"created_at",
		).
		From(TableUsersSc).
		Where(sq.Eq{
			"email":       email,
			"is_verified": true,
		}).
		ToSql()
	if err != nil {
		return entity.User{}, psql.ErrCreateQuery(op, err)
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
		return entity.User{}, psql.ErrDoQuery(op, err)
	}

	return user, nil
}

func (r *UserRepository) UserExists(ctx context.Context, email string) (bool, error) {
	logrus.WithFields(logrus.Fields{"email": email}).Trace("checking if user exists")
	const op string = "UserRepository.UserExists"

	sql, args, err := r.qb.
		Select("1").
		Prefix("SELECT EXISTS (").
		From(TableUsersSc).
		Where(sq.Eq{"email": email}).
		Suffix(")").
		ToSql()
	if err != nil {
		return false, psql.ErrCreateQuery(op, err)
	}

	var exists bool
	err = r.client.QueryRow(ctx, sql, args...).Scan(&exists)
	if err != nil {
		if err == pgx.ErrNoRows {
			return false, nil
		}
		return false, psql.ErrDoQuery(op, err)
	}

	return exists, nil
}

func (r *UserRepository) UserVerified(ctx context.Context, email string) (bool, error) {
	logrus.WithFields(logrus.Fields{"email": email}).Trace("checking if user is verified")
	const op string = "UserRepository.UserVerified"

	sql, args, err := r.qb.
		Select("is_verified").
		From(TableUsersSc).
		Where(sq.Eq{"email": email}).
		ToSql()
	if err != nil {
		return false, psql.ErrCreateQuery(op, err)
	}

	var verified bool
	err = r.client.QueryRow(ctx, sql, args...).Scan(&verified)
	if err != nil {
		if err == pgx.ErrNoRows {
			return false, nil
		}
		return false, psql.ErrDoQuery(op, err)
	}

	return verified, nil
}

func (r *UserRepository) DeleteUser(ctx context.Context, email string) error {
	logrus.WithField("email", email).Trace("deleting user")
	const op string = "UserRepository.DeleteUser"

	sql, args, err := r.qb.
		Delete(TableUsersSc).
		Where(sq.Eq{"email": email}).
		ToSql()
	if err != nil {
		return psql.ErrCreateQuery(op, err)
	}

	commTag, err := r.client.Exec(ctx, sql, args...)
	if err != nil {
		return psql.ErrExec(op, err)
	}

	if commTag.RowsAffected() == 0 {
		return psql.NoRowsAffected
	}

	return nil
}

func (r *UserRepository) AuthenticateUser(ctx context.Context, email, password string) (string, error) {
	logrus.WithField("email", email).Trace("authenticating user")
	const op string = "UserRepository.AuthenticateUser"

	sql, args, err := r.qb.
		Select("id").
		From(TableUsersSc).
		Where(sq.Eq{
			"email":       email,
			"password":    password,
			"is_verified": true,
		}).
		ToSql()
	if err != nil {
		return "", psql.ErrCreateQuery(op, err)
	}

	var userID string
	err = r.client.QueryRow(ctx, sql, args...).Scan(&userID)
	if errors.Is(err, pgx.ErrNoRows) {
		return "", nil
	}
	if err != nil {
		return "", psql.ErrDoQuery(op, err)
	}

	return userID, nil
}

func (r *UserRepository) VerifyEmail(ctx context.Context, email string) error {
	logrus.WithField("email", email).Trace("verifying user")
	const op string = "UserRepository.VerifyEmail"

	sql, args, err := r.qb.
		Update(TableUsersSc).
		Set("is_verified", true).
		Where(sq.Eq{"email": email}).
		ToSql()
	if err != nil {
		return psql.ErrCreateQuery(op, err)
	}

	commTag, err := r.client.Exec(ctx, sql, args...)
	if err != nil {
		return psql.ErrExec(op, err)
	}

	if commTag.RowsAffected() == 0 {
		return psql.NoRowsAffected
	}

	return nil
}
