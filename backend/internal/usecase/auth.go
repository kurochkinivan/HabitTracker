package usecase

import (
	"bytes"
	"context"
	"crypto/sha256"
	"fmt"
	"html/template"
	"math/rand"
	"time"

	"github.com/golang-jwt/jwt/v5"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	"github.com/sirupsen/logrus"
	"gopkg.in/gomail.v2"
)

var (
	tmpl   = template.Must(template.ParseFiles("../../static/html/confirmation_email_ru.html"))
	dialer = gomail.NewDialer("smtp.gmail.com", 587, "ivan.kurochkin.084@gmail.com", "hiqecckzffwewzqc")
)

type AuthUseCase struct {
	userRepo   UserRepository
	verifRepo  VerificationDataRepository
	signingKey string
	tokenTTL   time.Duration
	salt       string
	email      struct {
		from     string
		password string
	}
}

func NewAuthUseCase(userRepo UserRepository, verifRepo VerificationDataRepository, signingKey, salt string, tokenTTL time.Duration, emailFrom, emailPassword string) *AuthUseCase {
	return &AuthUseCase{
		userRepo:   userRepo,
		verifRepo:  verifRepo,
		signingKey: signingKey,
		tokenTTL:   tokenTTL,
		salt:       salt,
		email: struct {
			from     string
			password string
		}{
			from:     emailFrom,
			password: emailPassword,
		},
	}
}

// RegisterUser registers a new user in the database.
//
// It checks if the user with given email and name already exists.
// If the user exists, it returns an error.
// If the query to the database is failed, it returns the error.
func (a *AuthUseCase) RegisterUser(ctx context.Context, name, email, password string) error {
	logrus.WithFields(logrus.Fields{"name": name, "email": email}).Trace("registering new user")
	const op string = "usecase.RegisterUser"

	if name == "" || email == "" || password == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	user := entity.User{
		Name:     name,
		Email:    email,
		Password: a.hashPassword(password),
	}

	// TODO: Think: Remove status code, continue registration and send email to the user with this email.
	// smth like: "someone is trying to sign up using your email. If it was you, we remind you that you already have an account.
	// if it was not you, ignore this email"

	// TODO: add is user exists and verified
	exists, err := a.userRepo.IsUserExistsAndVerified(ctx, user.Email)
	if err != nil {
		return apperr.SystemError(err, "", fmt.Sprintf("%s: failed to check if user exists", op))
	}
	if exists {
		return apperr.ErrUserExists
	}

	err = a.userRepo.CreateUser(ctx, user)
	if err != nil {
		return apperr.SystemError(err, "", fmt.Sprintf("%s: failed to create user", op))
	}

	go func() error {
		code := a.generateCode()
		err = a.SendEmail(user.Email, code)
		if err != nil {
			return err
		}

		err = a.verifRepo.CreateVerificationData(ctx, user.Email, code)
		if err != nil {
			return apperr.SystemError(err, "", fmt.Sprintf("%s: failed to create verification data", op))
		}

		return nil
	}()

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

	user, err := a.userRepo.AuthenticateUser(ctx, email, a.hashPassword(password))
	if err != nil {
		return "", apperr.ErrAuthorizing.WithErr(err)
	}

	token, err := a.GenerateToken(user.ID, a.tokenTTL)
	if err != nil {
		return "", err
	}

	return token, nil
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

// GenerateToken generates a JWT token for given user ID and token TTL.
//
// It creates a JWT token with user ID and current time as payload.
// If the token signing is failed, it returns the error.
// If the token is successfully signed, it returns the signed token.
func (a *AuthUseCase) GenerateToken(id string, tokenTTL time.Duration) (string, error) {
	logrus.WithField("id", id).Trace("generating jwt-token")
	const op string = "usecase.GenerateToken"

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"ueid": id,
		"iat":  time.Now().Unix(),
		"exp":  time.Now().Add(tokenTTL).Unix(),
	})

	signedToken, err := token.SignedString([]byte(a.signingKey))
	if err != nil {
		logrus.WithError(err).Error("failed to sign token")
		return "", apperr.SystemError(err, "", fmt.Sprintf("%s: failed to sign token", op))
	}

	return signedToken, nil
}

func (a *AuthUseCase) SendEmail(email, code string) error {
	logrus.WithFields(logrus.Fields{"email": email, "code": code}).Trace("sending email")

	m := gomail.NewMessage()
	m.SetHeaders(map[string][]string{
		"From":    {a.email.from},
		"To":      {email},
		"Subject": {"Код Подтверждения"},
	})

	var body bytes.Buffer
	err := tmpl.Execute(&body, struct{ Code string }{Code: code})
	if err != nil {
		return apperr.SystemError(err, "", "failed to execute html-template")
	}
	m.SetBody("text/html", body.String())

	err = dialer.DialAndSend(m)
	if err != nil {
		return apperr.ErrSendingEmail.WithErr(err)
	}

	return nil
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

func (a *AuthUseCase) generateCode() string {
	return fmt.Sprintf("%04d", rand.Intn(10000))
}
