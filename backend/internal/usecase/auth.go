package usecase

import (
	"context"
	"crypto/sha256"
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	"github.com/sirupsen/logrus"
)

type AuthUseCase struct {
	repo       UserRepository
	signingKey string
	tokenTTL   time.Duration
	salt       string
}

func NewAuthUseCase(r UserRepository, signingKey, salt string, tokenTTL time.Duration) *AuthUseCase {
	return &AuthUseCase{
		repo:       r,
		signingKey: signingKey,
		tokenTTL:   tokenTTL,
		salt:       salt,
	}
}

func (a *AuthUseCase) RegisterUser(ctx context.Context, name, email, password string) error {
	logrus.WithFields(logrus.Fields{"name": name, "email": email}).Trace("registering new user")

	user := &entity.User{
		Name:     name,
		Email:    email,
		Password: a.hashPassword(password),
	}
	err := a.repo.CreateUser(ctx, user)
	if err != nil {
		return fmt.Errorf("failed to register user: %w", err)
	}

	return nil
}

func (a *AuthUseCase) GenerateToken(id string, tokenTTL time.Duration) (string, error) {
	logrus.WithField("id", id).Trace("generating jwt-token")

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"ueid": id,
		"iat":  time.Now().Unix(),
		"exp":  time.Now().Add(tokenTTL).Unix(),
	})

	signedToken, err := token.SignedString([]byte(a.signingKey))
	if err != nil {
		logrus.WithError(err).Error("failed to sign token")
		return "", fmt.Errorf("failed to sign token: %w", err)
	}

	return signedToken, nil
}

func (a *AuthUseCase) ParseToken(accessToken string) (jwt.MapClaims, error) {
	logrus.WithField("token", accessToken).Trace("parsing jwt-token")

	token, err := jwt.Parse(accessToken, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			logrus.Error(fmt.Sprintf("unexpected signing method: %v", t.Header["alg"]))
			return nil, fmt.Errorf("unexpected signing method: %v", t.Header["alg"])
		}
		return []byte(a.signingKey), nil
	})

	if err != nil {
		return nil, fmt.Errorf("failed to parse token: %w", err)
	}

	payload, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return nil, fmt.Errorf("failed to assert token to jwt.MapClaims: %w", err)
	}

	return payload, nil
}

func (a *AuthUseCase) hashPassword(password string) string {
	hash := sha256.New()
	hash.Write([]byte(password))

	return fmt.Sprintf("%x", hash.Sum([]byte(a.salt)))
}
