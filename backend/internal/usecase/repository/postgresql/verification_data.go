package postgresql

import (
	"context"
	"time"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

const (
	codeTTL time.Duration = 10 * time.Minute
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

// GetVerificationData retrieves verification data for the given email.
//
// It fetches the verification data from the database based on the provided email.
// If the query to fetch the data fails, it returns an error.
// If the verification data is successfully retrieved, it returns the verification data along with no error.
func (r *verificationDataRepository) GetVerificationData(ctx context.Context, email string) (entity.VerificationData, error) {
	logrus.WithField("email", email).Trace("getting verification data")

	sql, args, err := r.qb.
		Select(
			"id",
			"email",
			"code",
			"created_at",
			"expires_at",
		).
		From(verificationDataTable).
		Where(sq.Eq{"email": email}).
		ToSql()
	if err != nil {
		return entity.VerificationData{}, psql.ErrCreateQuery(err)
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
		return entity.VerificationData{}, psql.ErrDoQuery(err)
	}

	return verificationData, nil
}

// CreateVerificationData creates a new verification data for the given email.
//
// It inserts the verification data into the database with the given email and code.
// If the query to insert the data fails, it returns an error.
// If the verification data is successfully created, it returns no error.
func (r *verificationDataRepository) CreateVerificationData(ctx context.Context, email, code string) error {
	logrus.WithFields(logrus.Fields{"email": email, "code": code}).Trace("creating verification data")

	sql, args, err := r.qb.
		Insert(verificationDataTable).
		Columns(
			"email",
			"code",
			"created_at",
			"expires_at",
		).Values(
			email,
			code,
			time.Now(),
			time.Now().Add(codeTTL),
		).ToSql()
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
