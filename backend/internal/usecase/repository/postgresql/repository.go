package postgresql

import "github.com/jackc/pgx/v5/pgxpool"

type Repositories struct {
	User             *UserRepository
	VerificationData *VerificationDataRepository
	RefreshSessions  *RefreshSessionsRepository
	Habit            *HabitRepository
}

func NewRepositories(client *pgxpool.Pool) *Repositories {
	return &Repositories{
		User:             NewUserRepository(client),
		VerificationData: NewVerificationData(client),
		RefreshSessions:  NewRefreshSessionsRepository(client),
		Habit:            NewHabitRepository(client),
	}
}
