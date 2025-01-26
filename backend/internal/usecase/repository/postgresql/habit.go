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

func (r *HabitRepository) GetHabitSchedules(ctx context.Context, habitID int) ([]entity.HabitSchedules, error) {
	logrus.WithField("habit_id", habitID).Trace("getting habit schedules")
	const op string = "HabitRepository.GetHabitSchedules"

	sql, args, err := r.qb.
		Select(
			habitSchedulesField("id"),
			daysOfWeekField("name"),
		).
		From(TableHabitSchedules).
		LeftJoin(fmt.Sprintf("%s ON %s = %s", TableDaysOfWeek, habitSchedulesField("day_id"), daysOfWeekField("id"))).
		Where(sq.Eq{"habit_id": habitID}).
		ToSql()
	if err != nil {
		return nil, psql.ErrCreateQuery(op, err)
	}

	rows, err := r.client.Query(ctx, sql, args...)
	if err != nil {
		return nil, psql.ErrDoQuery(op, err)
	}

	schedules := []entity.HabitSchedules{}
	for rows.Next() {
		var schedule entity.HabitSchedules
		err := rows.Scan(
			&schedule.ID,
			&schedule.Day,
		)
		if err != nil {
			return nil, psql.ErrScan(op, err)
		}
		schedules = append(schedules, schedule)
	}
	if err := rows.Err(); err != nil {
		return nil, psql.ErrScan(op, err)
	}

	return schedules, nil
}

func (r *HabitRepository) GetHabitNotifications(ctx context.Context, habitID int) ([]entity.HabitNotification, error) {
	logrus.WithField("habit_id", habitID).Trace("getting habit notifications")
	const op string = "HabitRepository.GetHabitNotifications"

	sql, args, err := r.qb.
		Select(
			"id",
			"notification_time",
			"is_active",
		).
		From(TableHabitNotifications).
		Where(sq.Eq{"habit_id": habitID}).
		ToSql()
	if err != nil {
		return nil, psql.ErrCreateQuery(op, err)
	}

	rows, err := r.client.Query(ctx, sql, args...)
	if err != nil {
		return nil, psql.ErrDoQuery(op, err)
	}

	notifs := []entity.HabitNotification{}
	for rows.Next() {
		var notif entity.HabitNotification
		err := rows.Scan(
			&notif.ID,
			&notif.NotificationTime,
			&notif.IsActive,
		)
		if err != nil {
			return nil, psql.ErrScan(op, err)
		}
		notifs = append(notifs, notif)
	}
	if err := rows.Err(); err != nil {
		return nil, psql.ErrScan(op, err)
	}

	return notifs, nil
}

func (r *HabitRepository) GetUserHabits(ctx context.Context, userID string) ([]entity.Habit, error) {
	logrus.WithField("user_id", userID).Trace("getting habits")
	const op string = "HabitRepository.GetAllHabits"

	sql, args, err := r.qb.
		Select(
			habitsField("id"),
			habitsField("user_id"),
			habitsField("name"),
			habitsField("description"),
			categoriesField("name"),
			habitsField("interval"),
			habitsField("is_active"),
			habitsField("popularity_index"),
		).
		From(TableHabits).
		LeftJoin(fmt.Sprintf("%s ON %s = %s", TableCategories, habitsField("category_id"), categoriesField("id"))).
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
			&habit.IsActive,
			&habit.PopularityIndex,
		)
		if err != nil {
			return nil, psql.ErrScan(op, err)
		}

		notifs, err := r.GetHabitNotifications(ctx, habit.ID)
		if err != nil {
			return nil, err
		}
		habit.Notifications = notifs

		schedules, err := r.GetHabitSchedules(ctx, habit.ID)
		if err != nil {
			return nil, err
		}
		habit.Schedules = schedules

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

	sql, args, err := r.qb.
		Insert(TableHabits).
		Columns(
			"user_id",
			"name",
			"description",
			"category",
			"interval",
		).
		Values(
			habit.UserID,
			habit.Name,
			habit.Desc,
			habit.Category,
			habit.Interval,
		).
		ToSql()
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
