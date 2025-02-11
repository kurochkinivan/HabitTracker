package postgresql

import "fmt"

// The database schema to be used.
const scheme = "public."

// The names of tables in the database.
const (
	TableUsers                = "users"
	TableVerificationData     = "verification_data"
	TableRefreshSessions      = "refresh_sessions"
	TableHabits               = "habits"
	TableCategories           = "categories"
	TableHabitNotifications   = "habit_notifications"
	TableHabitSchedules       = "habit_schedules"
	TableDaysOfWeek           = "days_of_week"
	
	TableUsersSc              = scheme + "users"
	TableVerificationDataSc   = scheme + "verification_data"
	TableRefreshSessionsSc    = scheme + "refresh_sessions"
	TableHabitsSc             = scheme + "habits"
	TableCategoriesSc         = scheme + "categories"
	TableHabitNotificationsSc = scheme + "habit_notifications"
	TableHabitSchedulesSc     = scheme + "habit_schedules"
	TableDaysOfWeekSc         = scheme + "days_of_week"
)

func habitsField(field string) string {
	return fmt.Sprintf("%s.%s", TableHabitsSc, field)
}
func categoriesField(field string) string {
	return fmt.Sprintf("%s.%s", TableCategoriesSc, field)
}

func daysOfWeekField(field string) string {
	return fmt.Sprintf("%s.%s", TableDaysOfWeekSc, field)
}

func habitSchedulesField(field string) string {
	return fmt.Sprintf("%s.%s", TableHabitSchedulesSc, field)
}
