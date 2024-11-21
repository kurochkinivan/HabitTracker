package entity

import "time"

// TODO: Think of making id field of type uuid.UUID
type Habit struct {
	ID            string      `json:"id"`
	UserID        string      `json:"user_id"`
	Name          string      `json:"name"`
	Desc          string      `json:"desc"`
	Category      string      `json:"category"`
	Days          []int       `json:"days"`
	Interval      string      `json:"interval"`
	Notifications []time.Time `json:"notifications"`
}
