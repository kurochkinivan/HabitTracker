package usecase

import (
	"context"
	"time"

	"github.com/kurochkinivan/HabitTracker/internal/entity"
)

// TODO: think of generate mocks
//go:generate mockgen -source=interfaces.go -destination=./mocks_test.go -package=usecase_test

type (
	Auth interface {
		LoginUser(ctx context.Context, email, password, fingerprint string) (string, string, error)
		RefreshTokens(ctx context.Context, userID, refreshTkn, fingerprint string) (accessToken string, refreshToken string, err error)
		VerifyEmail(ctx context.Context, email, code, fingerprint string) (string, string, error)
		RegisterUser(ctx context.Context, name, email, password string) error
		SendConfirmationCode(ctx context.Context, email string) error
		LogoutUser(ctx context.Context, refreshToken string) error
	}

	UserRepository interface {
		AuthenticateUser(ctx context.Context, email, password string) (string, error)
		GetUserByEmail(ctx context.Context, email string) (entity.User, error)
		UserVerified(ctx context.Context, email string) (bool, error)
		UserExists(ctx context.Context, email string) (bool, error)
		CreateUser(ctx context.Context, user entity.User) error
		VerifyEmail(ctx context.Context, email string) error
		DeleteUser(ctx context.Context, email string) error
	}

	VerificationDataRepository interface {
		UpdateVerificationDataCode(ctx context.Context, verifData entity.VerificationData) error
		GetVerificationData(ctx context.Context, email string) (entity.VerificationData, error)
		CreateVerificationData(ctx context.Context, verifData entity.VerificationData) error
		VerificationDataExists(ctx context.Context, email string) (bool, error)
		DeleteVerificationData(ctx context.Context, email string) error
	}

	RefreshSessionsRepository interface {
		CreateRefreshSession(ctx context.Context, refreshSession entity.RefreshSession) (string, error)
		GetRefreshSession(ctx context.Context, refreshToken string) (entity.RefreshSession, error)
		CountRefreshSessions(ctx context.Context, userID string) (int, error)
		DeleteRefreshSessionsByUserID(ctx context.Context, userID string) error
		DeleteRefreshSessionByToken(ctx context.Context, refreshToken string) error
		DeleteRefreshSessionByFingerprint(ctx context.Context, fingerprint string) error
		RefreshSessionExists(ctx context.Context, fingerprint string) (bool, error)
	}
)

type (
	Habit interface {
		CreateHabit(ctx context.Context, habit entity.Habit, notificationTimes []time.Time, scheduleDays []int) error
		GetUserHabits(ctx context.Context, userID string) ([]entity.Habit, error)
		GetCategories(ctx context.Context) ([]entity.Category, error)
		GetDaysOfWeek(ctx context.Context) ([]entity.DayOfWeek, error)
	}

	HabitRepository interface {
		// CreateHabit(ctx context.Context, habit entity.Habit) error
		// CreateNotifications(ctx context.Context, habitID int, notificationTimes []time.Time) error
		// CreateSchedules(ctx context.Context, habitID int, scheduleDays []int) error
		CreateHabitTx(ctx context.Context, habit entity.Habit, notificationTimes []time.Time, scheduleDays []int) error
		GetUserHabits(ctx context.Context, userID string) ([]entity.Habit, error)
		GetCategories(ctx context.Context) ([]entity.Category, error)
		GetDaysOfWeek(ctx context.Context) ([]entity.DayOfWeek, error)
	}
)
