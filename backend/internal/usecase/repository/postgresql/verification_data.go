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

type verificationDataRepository struct {
	client psql.PosgreSQLClient
	qb     sq.StatementBuilderType
}

func NewVerificationData(client *pgxpool.Pool) *verificationDataRepository {
	return &verificationDataRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

func (r *verificationDataRepository) GetVerificationData(ctx context.Context, email string) (entity.VerificationData, error) {
	logrus.WithField("email", email).Trace("getting verification data")
	const op string = "postgresql.GetVerificationData"

	sql, args, err := r.qb.
		Select(
			"id",
			"email",
			"code",
			"created_at",
			"expires_at",
		).
		From(TableVerificationData).
		Where(sq.Eq{"email": email}).
		ToSql()
	if err != nil {
		return entity.VerificationData{}, psql.ErrCreateQuery(op, err)
	}

	var verificationData entity.VerificationData
	err = r.client.QueryRow(ctx, sql, args...).Scan(
		&verificationData.ID,
		&verificationData.Email,
		&verificationData.Code,
		&verificationData.CreatedAt,
		&verificationData.ExpiresAt,
	)
	if err != nil {
		return entity.VerificationData{}, psql.ErrDoQuery(op, err)
	}

	return verificationData, nil
}

func (r *verificationDataRepository) CreateVerificationData(ctx context.Context, verifData entity.VerificationData) error {
	logrus.WithFields(logrus.Fields{"email": verifData.Email, "code": verifData.Code}).Trace("creating verification data")
	const op string = "postgresql.CreateVerificationData"

	sql, args, err := r.qb.
		Insert(TableVerificationData).
		Columns(
			"email",
			"code",
			"created_at",
			"expires_at",
		).
		Values(
			verifData.Email,
			verifData.Code,
			verifData.CreatedAt,
			verifData.ExpiresAt,
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

func (r *verificationDataRepository) VerificationDataExists(ctx context.Context, email string) (bool, error) {
	logrus.WithField("email", email).Trace("checking if verification data exists")
	const op string = "postgresql.VerificationDataExists"

	sql, args, err := r.qb.
		Select("1").
		Prefix("SELECT EXISTS (").
		From(TableVerificationData).
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

func (r *verificationDataRepository) DeleteVerificationData(ctx context.Context, email string) error {
	logrus.WithField("email", email).Trace("deleting verification data")
	const op string = "postgresql.DeleteVerificationData"

	sql, args, err := r.qb.
		Delete(TableVerificationData).
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

func (r *verificationDataRepository) UpdateVerificationDataCode(ctx context.Context, verifData entity.VerificationData) error {
	logrus.WithFields(logrus.Fields{"email": verifData.Email, "code": verifData.Code}).Trace("updating verification data code")
	const op string = "postgresql.UpdateVerificationDataCode"

	sql, args, err := r.qb.
		Update(TableVerificationData).
		SetMap(map[string]interface{}{
			"code":       verifData.Code,
			"created_at": verifData.CreatedAt,
			"expires_at": verifData.ExpiresAt,
		}).
		Where(sq.Eq{"email": verifData.Email}).
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
