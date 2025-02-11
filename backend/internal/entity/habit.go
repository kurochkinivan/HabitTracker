package entity

// TODO: Think of making id field of type uuid.UUID
type Habit struct {
	ID              int                 `json:"id"`
	UserID          string              `json:"-"`
	Name            string              `json:"name"`
	Desc            string              `json:"desc"`
	Interval        string              `json:"interval"`
	IsActive        bool                `json:"is_active"`
	PopularityIndex string              `json:"popularity_index"`
	Category        Category            `json:"category"`
	Notifications   []HabitNotification `json:"notifications"`
	Schedules       []HabitSchedules    `json:"schedules"`
}
