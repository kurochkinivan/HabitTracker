package entity

// TODO: Think of making id field of type uuid.UUID
type Habit struct {
	ID              int                 `json:"id"`
	UserID          string              `json:"user_id"`
	Name            string              `json:"name"`
	Desc            string              `json:"desc"`
	Category        string              `json:"category"`
	Interval        string              `json:"interval"`
	IsActive        bool                `json:"is_active"`
	PopularityIndex string              `json:"popularity_index"`
	Notifications   []HabitNotification `json:"notifications"`
	Schedules       []HabitSchedules    `json:"schedules"`
}
