package entity

type Category struct {
	ID     int    `json:"id"`
	Name   string `json:"name"`
	UserID string `json:"user_id"`
}
