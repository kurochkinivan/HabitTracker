package entity

import "time"

type RefreshSession struct {
	ID           int       `json:"-"`
	UserID       string    `json:"-"`
	RefreshToken string    `json:"refresh_token"`
	Fingerprint  string    `json:"-"`
	IssuedAt     time.Time `json:"-"`
	Expiration   time.Time `json:"-"`
}
