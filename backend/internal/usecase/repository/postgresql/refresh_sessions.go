package postgresql

import (
	"context"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

type resfreshSessionsRepository struct {
	client psql.PosgreSQLClient
	qb     sq.StatementBuilderType
}

func NewRefreshSessionsRepository(client *pgxpool.Pool) *resfreshSessionsRepository {
	return &resfreshSessionsRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

func (r *resfreshSessionsRepository) CreateRefreshSession(ctx context.Context, refreshSession entity.RefreshSession) (string, error) {
	logrus.WithField("user_id", refreshSession.UserID).Trace("creating refresh session")

	sql, args, err := r.qb.
		Insert(TableRefreshSessions).
		Columns(
			"user_id",
			"fingerprint",
			"issued_at",
			"expiration",
		).Values(
			refreshSession.UserID,
			refreshSession.Fingerprint,
			refreshSession.IssuedAt,
			refreshSession.Expiration,
		).Suffix("RETURNING refresh_token").
		ToSql()
	if err != nil {
		return "", psql.ErrCreateQuery(err)
	}

	var refresh string
	err = r.client.QueryRow(ctx, sql, args...).Scan(&refresh)
	if err != nil {
		return "", psql.ErrDoQuery(err)
	}

	return refresh, nil 
}

// func (r *resfreshSessionsRepository) DeleteRefreshSession(ctx context.Context, refreshToken string) error {
// 	logrus.WithField("refresh_token", refreshToken).Trace("deleting refresh session")

// 	sql, args, err := r.qb.
// 		Delete(TableRefreshSessions). 

// }
