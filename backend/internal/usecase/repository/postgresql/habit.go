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

func (r *HabitRepository) CreateHabit(habit entity.Habit) error {
	logrus.WithField("user_id", habit.UserID).Trace("creating new habit")
	const op string = "HabitRepository.CreateHabit"

	sql, args, err := r.qb.Insert(TableHabits).Columns(
		"user_id",
		"name",
		"description",
		"category",
		"days",
		"interval",
		"notifications",
	).Values(
		habit.UserID,
		habit.Name,
		habit.Desc,
		habit.Category,
		habit.Days,
		habit.Interval,
		habit.Notifications,
	).ToSql()
	if err != nil {
		return psql.ErrCreateQuery(op, err)
	}
	fmt.Println(sql)
	fmt.Println(args...)

	commTag, err := r.client.Exec(context.TODO(), sql, args...)
	if err != nil {
		return psql.ErrExec(op, err)
	}

	if commTag.RowsAffected() == 0{
		return psql.NoRowsAffected
	}

	return nil
}
