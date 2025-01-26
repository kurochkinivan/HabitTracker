package entity

type HabitSchedules struct {
	ID      int    `json:"id"`
	HabitID int    `json:"-"`
	Day     string `json:"day"`
}
