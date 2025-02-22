package postgresql

import (
	"context"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

type CategoryRepository struct {
	client *pgxpool.Pool
	qb     sq.StatementBuilderType
}

func NewCategoryRepository(client *pgxpool.Pool) *CategoryRepository {
	return &CategoryRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

func (r *CategoryRepository) GetCategories(ctx context.Context, userID string) ([]*entity.Category, error) {
	logrus.Trace("getting categories")
	const op string = "CategoryRepository.GetCategories"

	sql, args, err := r.qb.
		Select(
			"id",
			"name",
		).
		From(TableCategoriesSc).
		Where(sq.Or{sq.Eq{"user_id": nil}, sq.Eq{"user_id": userID}}).
		ToSql()
	if err != nil {
		return nil, psql.ErrCreateQuery(op, err)
	}

	rows, err := r.client.Query(ctx, sql, args...)
	if err != nil {
		return nil, psql.ErrDoQuery(op, err)
	}

	categories := []*entity.Category{}
	for rows.Next() {
		category := &entity.Category{}
		err := rows.Scan(
			&category.ID,
			&category.Name,
		)
		if err != nil {
			return nil, psql.ErrScan(op, err)
		}

		categories = append(categories, category)
	}
	if err := rows.Err(); err != nil {
		return nil, psql.ErrScan(op, err)
	}

	return categories, nil
}

func (r *CategoryRepository) CreateCategory(ctx context.Context, userID string, category *entity.Category) error {
	logrus.WithField("user_id", userID).Trace("creating category")
	const op string = "CategoryRepository.CreateCategory"

	sql, args, err := r.qb.
		Insert(TableCategoriesSc).
		Columns(
			"name",
			"user_id",
		).
		Values(
			category.Name,
			userID,
		).
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
