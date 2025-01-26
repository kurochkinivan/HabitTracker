package entity

import "time"

type HabitNotification struct {
	ID               int       `json:"id"`
	HabitID          int       `json:"-"`
	NotificationTime time.Time `json:"notification_time"`
	IsActive         bool      `json:"is_active"`
}
