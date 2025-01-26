package postgresql

import (
	"context"
	"fmt"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

type HabitRepository struct {
	client psql.PosgreSQLClient
	qb     sq.StatementBuilderType
}

func NewHabitRepository(client *pgxpool.Pool) *HabitRepository {
	return &HabitRepository{
		client: client,
		qb:     sq.StatementBuilder.PlaceholderFormat(sq.Dollar),
	}
}

func (r *HabitRepository) GetUserHabits(ctx context.Context, userID string) ([]entity.Habit, error) {
	logrus.WithField("user_id", userID).Trace("getting habits")
	const op string = "HabitRepository.GetAllHabits"

	sql, args, err := r.qb.Select(
		habitsField("id"),
		habitsField("user_id"),
		habitsField("name"),
		habitsField("description"),
		categoriesField("name"),
		habitsField("interval"),
		habitsField("active"),
		habitsField("popularity_index"),
	).
		From(TableHabits).
		InnerJoin(fmt.Sprintf("categories ON %s = %s", habitsField("category_id"), categoriesField("id"))).
		Where(sq.Eq{"user_id": userID}).
		ToSql()
	if err != nil {
		return nil, psql.ErrCreateQuery(op, err)
	}

	rows, err := r.client.Query(ctx, sql, args...)
	if err != nil {
		return nil, psql.ErrDoQuery(op, err)
	}
	defer rows.Close()

	habits := []entity.Habit{}
	for rows.Next() {
		var habit entity.Habit
		err := rows.Scan(
			&habit.ID,
			&habit.UserID,
			&habit.Name,
			&habit.Desc,
			&habit.Category,
			&habit.Interval,
			&habit.Active,
			&habit.PopularityIndex,
		)
		if err != nil {
			return nil, psql.ErrScan(op, err)
		}
		habits = append(habits, habit)
	}
	if err := rows.Err(); err != nil {
		return nil, psql.ErrScan(op, err)
	}

	return habits, nil
}

func (r *HabitRepository) CreateHabit(ctx context.Context, habit entity.Habit) error {
	logrus.WithField("user_id", habit.UserID).Trace("creating new habit")
	const op string = "HabitRepository.CreateHabit"

	sql, args, err := r.qb.Insert(TableHabits).Columns(
		"user_id",
		"name",
		"description",
		"category",
		"interval",
	).Values(
		habit.UserID,
		habit.Name,
		habit.Desc,
		habit.Category,
		habit.Interval,
	).ToSql()
	if err != nil {
		return psql.ErrCreateQuery(op, err)
	}

	commTag, err := r.client.Exec(context.TODO(), sql, args...)
	if err != nil {
		return psql.ErrExec(op, err)
	}

	if commTag.RowsAffected() == 0 {
		return psql.NoRowsAffected
	}

	return nil
}
