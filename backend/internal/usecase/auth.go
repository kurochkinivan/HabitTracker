package usecase

import (
	"context"
	"crypto/sha256"
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v5"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
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

// RegisterUser registers a new user in the database.
//
// It checks if the user with given email and name already exists.
// If the user exists, it returns an error.
// If the query to the database is failed, it returns the error.
func (a *AuthUseCase) RegisterUser(ctx context.Context, name, email, password string) error {
	logrus.WithFields(logrus.Fields{"name": name, "email": email}).Trace("registering new user")

	if name == "" || email == "" || password == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	user := entity.User{
		Name:     name,
		Email:    email,
		Password: a.hashPassword(password),
	}

	// TODO: Remove status code, continue registration and send email to the user with this email.
	// smth like: "someone is trying to sign up using your email. If it was you, we remind you that you already have an account.
	// if it was not you, ignore this email"
	exists, err := a.repo.IsUserExists(ctx, user.Email)
	if err != nil {
		return apperr.SystemError(err, "", "usecase.RegisterUser: failed to check if user exists")
	}
	if exists {
		return apperr.ErrUserExists
	}

	err = a.repo.CreateUser(ctx, user)
	if err != nil {
		return apperr.SystemError(err, "", "usecase.RegisterUser: failed to create user")
	}

	return nil
}

// LoginUser logs a user in.
//
// It checks the user's credentials against the data in the database.
// If the credentials are invalid, it returns an error.
// If the query to the database is failed, it returns the error.
// If the user is successfully logged in, it returns a JWT token.
func (a *AuthUseCase) LoginUser(ctx context.Context, email, password string) (string, error) {
	logrus.WithField("email", email).Trace("logging user")

	if email == "" || password == "" {
		return "", apperr.ErrNotAllFieldsProvided
	}

	user, err := a.repo.AuthenticateUser(ctx, email, a.hashPassword(password))
	if err != nil {
		return "", apperr.ErrAuthorizing.WithErr(err)
	}

	token, err := a.generateToken(user.ID, a.tokenTTL)
	if err != nil {
		return "",  err
	}

	return token, nil
}

// GenerateToken generates a JWT token for given user ID and token TTL.
//
// It creates a JWT token with user ID and current time as payload.
// If the token signing is failed, it returns the error.
// If the token is successfully signed, it returns the signed token.
func (a *AuthUseCase) generateToken(id string, tokenTTL time.Duration) (string, error) {
	logrus.WithField("id", id).Trace("generating jwt-token")

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"ueid": id,
		"iat":  time.Now().Unix(),
		"exp":  time.Now().Add(tokenTTL).Unix(),
	})

	signedToken, err := token.SignedString([]byte(a.signingKey))
	if err != nil {
		logrus.WithError(err).Error("failed to sign token")
		return "", apperr.SystemError(err, "", "usecase.GenerateToken: failed to sign token")
	}

	return signedToken, nil
}

// ParseToken parses the given JWT token and returns its payload.
//
// It checks the token's signing method and signature.
// If the token is invalid, it returns an error.
// If the token is successfully parsed, it returns its payload.
func (a *AuthUseCase) ParseToken(accessToken string) (jwt.MapClaims, error) {
	logrus.WithField("token", accessToken).Trace("parsing jwt-token")

	token, err := jwt.Parse(accessToken, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			logrus.WithField("alg", t.Header["alg"]).Error("unexpected signing method")
			return nil, apperr.SystemError(nil, "", "usecase.ParseToken: unexpected signing method")
		}
		return []byte(a.signingKey), nil
	})

	if err != nil {
		return nil, apperr.ErrInvalidAuthHeader.WithErr(err)
	}

	payload, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		logrus.Error("usecase.ParseToken: token claims are not of type jwt.MapClaims")
		return nil, apperr.SystemError(err, "", "usecase.ParseToken: token claims are not of type jwt.MapClaims")
	}

	return payload, nil
}

// hashPassword hashes a given password with the stored salt.
//
// It uses the SHA-256 hashing algorithm.
// The salt is used to prevent attacks using precomputed tables (rainbow tables).
// The resulting hash is a hex string.
func (a *AuthUseCase) hashPassword(password string) string {
	hash := sha256.New()
	hash.Write([]byte(password))

	return fmt.Sprintf("%x", hash.Sum([]byte(a.salt)))
}
