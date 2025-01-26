package postgresql

import "fmt"

// The database schema to be used.
const scheme = "public."

// The names of tables in the database.
const (
	TableUsers              = scheme + "users"
	TableVerificationData   = scheme + "verification_data"
	TableRefreshSessions    = scheme + "refresh_sessions"
	TableHabits             = scheme + "habits"
	TableCategories         = scheme + "categories"
	TableHabitNotifications = scheme + "habit_notifications"
	TableHabitSchedules     = scheme + "habit_schedules"
	TableDaysOfWeek         = scheme + "days_of_week"
)

func habitsField(field string) string {
	return fmt.Sprintf("%s.%s", TableHabits, field)
}
func categoriesField(field string) string {
	return fmt.Sprintf("%s.%s", TableCategories, field)
}

func daysOfWeekField(field string) string {
	return fmt.Sprintf("%s.%s", TableDaysOfWeek, field)
}

func habitSchedulesField(field string) string {
	return fmt.Sprintf("%s.%s", TableHabitSchedules, field)
}


