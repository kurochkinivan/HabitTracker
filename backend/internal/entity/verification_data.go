package entity

import "time"

type VerificationData struct {
	ID        int       `json:"-"`
	Email     string    `json:"-"`
	Code      string    `json:"-"`
	CreatedAt time.Time `json:"-"`
	ExpiresAt time.Time `json:"-"`
}
