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

type VerificationDataRepository struct {
	client *pgxpool.Pool
	qb     sq.StatementBuilderType
}

func NewVerificationData(client *pgxpool.Pool) *VerificationDataRepository {
	return &VerificationDataRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

func (r *VerificationDataRepository) GetVerificationData(ctx context.Context, email string) (entity.VerificationData, error) {
	logrus.WithField("email", email).Trace("getting verification data")
	const op string = "VerificationDataRepository.GetVerificationData"

	sql, args, err := r.qb.
		Select(
			"id",
			"email",
			"code",
			"created_at",
			"expires_at",
		).
		From(TableVerificationDataSc).
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

func (r *VerificationDataRepository) CreateVerificationData(ctx context.Context, verifData entity.VerificationData) error {
	logrus.WithFields(logrus.Fields{"email": verifData.Email, "code": verifData.Code}).Trace("creating verification data")
	const op string = "VerificationDataRepository.CreateVerificationData"

	sql, args, err := r.qb.
		Insert(TableVerificationDataSc).
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

func (r *VerificationDataRepository) VerificationDataExists(ctx context.Context, email string) (bool, error) {
	logrus.WithField("email", email).Trace("checking if verification data exists")
	const op string = "VerificationDataRepository.VerificationDataExists"

	sql, args, err := r.qb.
		Select("1").
		Prefix("SELECT EXISTS (").
		From(TableVerificationDataSc).
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

func (r *VerificationDataRepository) DeleteVerificationData(ctx context.Context, email string) error {
	logrus.WithField("email", email).Trace("deleting verification data")
	const op string = "VerificationDataRepository.DeleteVerificationData"

	sql, args, err := r.qb.
		Delete(TableVerificationDataSc).
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

func (r *VerificationDataRepository) UpdateVerificationDataCode(ctx context.Context, verifData entity.VerificationData) error {
	logrus.WithFields(logrus.Fields{"email": verifData.Email, "code": verifData.Code}).Trace("updating verification data code")
	const op string = "VerificationDataRepository.UpdateVerificationDataCode"

	sql, args, err := r.qb.
		Update(TableVerificationDataSc).
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
