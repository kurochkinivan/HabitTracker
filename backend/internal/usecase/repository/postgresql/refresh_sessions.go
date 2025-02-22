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

type RefreshSessionsRepository struct {
	client *pgxpool.Pool
	qb     sq.StatementBuilderType
}

func NewRefreshSessionsRepository(client *pgxpool.Pool) *RefreshSessionsRepository {
	return &RefreshSessionsRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

// TODO: think about no rows affected error

func (r *RefreshSessionsRepository) CreateRefreshSession(ctx context.Context, refreshSession entity.RefreshSession) (string, error) {
	logrus.WithField("user_id", refreshSession.UserID).Trace("creating refresh session")
	const op string = "RefreshSessionsRepository.CreateRefreshSession"

	sql, args, err := r.qb.
		Insert(TableRefreshSessionsSc).
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
		return "", psql.ErrCreateQuery(op, err)
	}

	var refresh string
	err = r.client.QueryRow(ctx, sql, args...).Scan(&refresh)
	if err != nil {
		return "", psql.ErrDoQuery(op, err)
	}

	return refresh, nil
}

func (r *RefreshSessionsRepository) CountRefreshSessions(ctx context.Context, userID string) (int, error) {
	logrus.WithField("user_id", userID).Trace("counting refresh sessions")
	const op string = "RefreshSessionsRepository.CountRefreshSessions"

	sql, args, err := r.qb.Select("COUNT (*)").
		FromSelect(r.qb.Select("user_id").From(TableRefreshSessionsSc).Where(sq.Eq{"user_id": userID}), "session_by_user_id").
		ToSql()
	if err != nil {
		return 0, psql.ErrCreateQuery(op, err)
	}

	var count int
	err = r.client.QueryRow(ctx, sql, args...).Scan(&count)
	if err != nil {
		return 0, psql.ErrDoQuery(op, err)
	}

	return count, nil
}

func (r *RefreshSessionsRepository) DeleteRefreshSessionsByUserID(ctx context.Context, userID string) error {
	logrus.WithField("user_id", userID).Trace("deleting refresh sessions")
	const op string = "RefreshSessionsRepository.DeleteRefreshSessions"

	sql, args, err := r.qb.
		Delete(TableRefreshSessionsSc).
		Where(sq.Eq{"user_id": userID}).
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

func (r *RefreshSessionsRepository) DeleteRefreshSessionByToken(ctx context.Context, refreshToken string) error {
	logrus.WithField("refresh_token", refreshToken).Trace("deleting refresh session")
	const op string = "RefreshSessionsRepository.DeleteRefreshSession"

	sql, args, err := r.qb.
		Delete(TableRefreshSessionsSc).
		Where(sq.Eq{"refresh_token": refreshToken}).
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

func (r *RefreshSessionsRepository) GetRefreshSession(ctx context.Context, refreshToken string) (entity.RefreshSession, error) {
	logrus.WithField("refreshToken", refreshToken).Trace("getting refresh session")
	const op string = "RefreshSessionsRepository.GetRefreshSession"

	sql, args, err := r.qb.Select(
		"id",
		"user_id",
		"refresh_token",
		"fingerprint",
		"issued_at",
		"expiration",
	).
		From(TableRefreshSessionsSc).
		Where(sq.Eq{"refresh_token": refreshToken}).
		ToSql()
	if err != nil {
		return entity.RefreshSession{}, psql.ErrCreateQuery(op, err)
	}

	var refreshSession entity.RefreshSession
	err = r.client.QueryRow(ctx, sql, args...).Scan(
		&refreshSession.ID,
		&refreshSession.UserID,
		&refreshSession.RefreshToken,
		&refreshSession.Fingerprint,
		&refreshSession.IssuedAt,
		&refreshSession.Expiration,
	)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return entity.RefreshSession{}, nil
		}
		return entity.RefreshSession{}, psql.ErrDoQuery(op, err)
	}

	return refreshSession, nil
}

func (r *RefreshSessionsRepository) RefreshSessionExists(ctx context.Context, fingerprint string) (bool, error) {
	logrus.WithField("fingerprint", fingerprint).Trace("checking if refresh session exists")
	const op string = "RefreshSessionsRepository.RefreshSessionExists"

	sql, args, err := r.qb.
		Select("1").
		Prefix("SELECT EXISTS (").
		From(TableRefreshSessionsSc).
		Where(sq.Eq{"fingerprint": fingerprint}).
		Suffix(")").
		ToSql()
	if err != nil {
		return false, psql.ErrCreateQuery(op, err)
	}

	var exists bool
	err = r.client.QueryRow(ctx, sql, args...).Scan(&exists)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return false, nil
		}
		return false, psql.ErrDoQuery(op, err)
	}

	return exists, nil
}

func (r *RefreshSessionsRepository) DeleteRefreshSessionByFingerprint(ctx context.Context, fingerprint string) error {
	logrus.WithField("fingerprint", fingerprint).Trace("deleting refresh session")
	const op string = "RefreshSessionsRepository.DeleteRefreshSessionByFingerprint"

	sql, args, err := r.qb.
		Delete(TableRefreshSessionsSc).
		Where(sq.Eq{"fingerprint": fingerprint}).
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
