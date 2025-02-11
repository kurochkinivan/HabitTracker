package postgresql

import (
	"context"
	"fmt"
	"time"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	psql "github.com/kurochkinivan/HabitTracker/pkg/postgresql"
	"github.com/sirupsen/logrus"
)

type HabitRepository struct {
	client *pgxpool.Pool
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
		From(TableHabitSchedulesSc).
		LeftJoin(fmt.Sprintf("%s ON %s = %s", TableDaysOfWeekSc, habitSchedulesField("day_id"), daysOfWeekField("id"))).
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
		From(TableHabitNotificationsSc).
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
	const op string = "HabitRepository.GetUserHabits"

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
		From(TableHabitsSc).
		LeftJoin(fmt.Sprintf("%s ON %s = %s", TableCategoriesSc, habitsField("category_id"), categoriesField("id"))).
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
			&habit.Category.Name,
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

func (r *HabitRepository) CreateHabitTx(ctx context.Context, habit entity.Habit, notificationTimes []time.Time, scheduleDays []int) error {
	logrus.WithField("user_id", habit.UserID).Trace("starting create habit transaction")
	const op string = "HabitRepository.CreateHabitTx"

	tx, err := r.client.Begin(ctx)
	if err != nil {
		return psql.ErrCreateTx(op, err)
	}
	defer tx.Rollback(ctx)

	sql, args, err := r.qb.
		Insert(TableHabitsSc).
		Columns(
			"user_id",
			"name",
			"description",
			"category_id",
			"interval",
			"is_active",
		).
		Values(
			habit.UserID,
			habit.Name,
			habit.Desc,
			habit.Category.ID,
			habit.Interval,
			habit.IsActive,
		).
		Suffix("RETURNING id").
		ToSql()
	if err != nil {
		return psql.ErrCreateQuery(op, err)
	}

	var habitID int
	err = tx.QueryRow(ctx, sql, args...).Scan(&habitID)
	if err != nil {
		return psql.ErrScan(op, err)
	}

	_, err = tx.CopyFrom(
		ctx,
		pgx.Identifier{TableHabitNotifications},
		[]string{"habit_id", "notification_time", "is_active"},
		pgx.CopyFromSlice(len(notificationTimes), func(i int) ([]any, error) {
			return []any{habitID, notificationTimes[i], true}, nil
		}),
	)
	if err != nil {
		return psql.ErrInsertMultipleRows(op, err)
	}

	_, err = tx.CopyFrom(
		ctx,
		pgx.Identifier{TableHabitSchedules},
		[]string{"habit_id", "day_id"},
		pgx.CopyFromSlice(len(notificationTimes), func(i int) ([]any, error) {
			return []any{habitID, scheduleDays[i]}, nil
		}),
	)
	if err != nil {
		return psql.ErrInsertMultipleRows(op, err)
	}

	err = tx.Commit(ctx)
	if err != nil {
		return psql.ErrCommit(op, err)
	}

	return nil
}

func (r *HabitRepository) GetCategories(ctx context.Context) ([]entity.Category, error) {
	logrus.Trace("getting categories")
	const op string = "HabitRepository.GetCategories"

	sql, args, err := r.qb.
		Select(
			"id",
			"name",
		).
		From(TableCategoriesSc).
		ToSql()
	if err != nil {
		return nil, psql.ErrCreateQuery(op, err)
	}

	rows, err := r.client.Query(ctx, sql, args...)
	if err != nil {
		return nil, psql.ErrDoQuery(op, err)
	}

	categories := []entity.Category{}
	for rows.Next() {
		var category entity.Category
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

func (r *HabitRepository) GetDaysOfWeek(ctx context.Context) ([]entity.DayOfWeek, error) {
	logrus.Trace("getting categories")
	const op string = "HabitRepository.GetDays"

	sql, args, err := r.qb.
		Select(
			"id",
			"name",
		).
		From(TableDaysOfWeekSc).
		ToSql()
	if err != nil {
		return nil, psql.ErrCreateQuery(op, err)
	}

	rows, err := r.client.Query(ctx, sql, args...)
	if err != nil {
		return nil, psql.ErrDoQuery(op, err)
	}

	days := []entity.DayOfWeek{}
	for rows.Next() {

		var day entity.DayOfWeek
		err := rows.Scan(
			&day.ID,
			&day.Name,
		)
		if err != nil {
			return nil, psql.ErrScan(op, err)
		}

		days = append(days, day)
	}
	if err := rows.Err(); err != nil {
		return nil, psql.ErrScan(op, err)
	}

	return days, nil
}
