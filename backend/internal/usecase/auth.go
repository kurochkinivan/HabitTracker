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
	"github.com/kurochkinivan/HabitTracker/config"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/entity"
	"github.com/sirupsen/logrus"
	"gopkg.in/gomail.v2"
)

var (
	tmplConfirm, tmplEmailExists *template.Template
	sender                       gomail.SendCloser
)

const (
	ConfirmationMessage = iota
	EmailExistsMessage
)

func init() {
	tmplConfirm = template.Must(template.ParseFiles("../../static/html/confirmation_email.html"))
	tmplEmailExists = template.Must(template.ParseFiles("../../static/html/email_already_exists.html"))
	// tmplConfirm = template.Must(template.ParseFiles("confirmation_email.html"))
	// tmplEmailExists = template.Must(template.ParseFiles("email_already_exists.html"))
	dialer := gomail.NewDialer("smtp.gmail.com", 587, "ivan.kurochkin.084@gmail.com", "hiqecckzffwewzqc")
	var err error
	sender, err = dialer.Dial()
	if err != nil {
		logrus.Fatal(err)
	}
}

type AuthUseCase struct {
	userRepo        UserRepository
	verifRepo       VerificationDataRepository
	refreshRepo     RefreshSessionsRepository
	signingKey      string
	accessTokenTTL  time.Duration
	refreshTokenTTL time.Duration
	verifCodeTTL    time.Duration
	maxUserSessions int
	salt            string
	emailFrom       string
	emailPassword   string
}

func NewAuthUseCase(userRepo UserRepository, verifRepo VerificationDataRepository, refreshRepo RefreshSessionsRepository, auth config.Auth) *AuthUseCase {
	return &AuthUseCase{
		userRepo:        userRepo,
		verifRepo:       verifRepo,
		refreshRepo:     refreshRepo,
		signingKey:      auth.JWT.JWTSignKey,
		accessTokenTTL:  auth.JWT.AccessTokenTTL,
		refreshTokenTTL: auth.JWT.RefreshTokenTTL,
		maxUserSessions: auth.JWT.MaxUserSessions,
		verifCodeTTL:    auth.Email.VerifCodeTTL,
		emailFrom:       auth.Email.EmailFrom,
		emailPassword:   auth.Email.EmailPassword,
		salt:            auth.Hasher.HasherSalt,
	}
}

// TODO: Think of using goroutines for sending emails
func (a *AuthUseCase) RegisterUser(ctx context.Context, name, email, password string) error {
	logrus.WithFields(logrus.Fields{"name": name, "email": email}).Trace("registering new user")
	const op string = "usecase.RegisterUser"

	user := entity.User{
		Name:     name,
		Email:    email,
		Password: a.hashPassword(password),
	}

	exists, err := a.userRepo.UserExists(ctx, user.Email)
	if err != nil {
		return apperr.SystemError(err, op, "failed to check if user exists")
	}
	if exists {
		verified, err := a.userRepo.UserVerified(ctx, user.Email)
		if err != nil {
			return apperr.SystemError(err, op, "failed to check if user is verified")
		}

		if verified {
			return apperr.ErrUserExists
		} else {
			err = a.userRepo.DeleteUser(ctx, email)
			if err != nil {
				return apperr.SystemError(err, op, "failed to delete user")
			}
		}
	}

	err = a.userRepo.CreateUser(ctx, user)
	if err != nil {
		return apperr.SystemError(err, op, "failed to create user")
	}

	err = a.SendConfirmationCode(ctx, email)
	if err != nil {
		return apperr.ErrSendingEmail.WithErr(err)
	}

	return nil
}

func (a *AuthUseCase) LoginUser(ctx context.Context, email, password, fingerprint string) (string, string, error) {
	logrus.WithField("email", email).Trace("logging user in")
	const op string = "usecase.LoginUser"

	userID, err := a.userRepo.AuthenticateUser(ctx, email, a.hashPassword(password))
	if err != nil {
		return "", "", apperr.SystemError(err, op, "failed to authenticate user")
	}
	if userID == "" {
		return "", "", apperr.ErrAuthorizing
	}

	accessToken, refreshToken, err := a.GenerateTokenPair(ctx, userID, fingerprint, a.accessTokenTTL, a.refreshTokenTTL)
	if err != nil {
		return "", "", fmt.Errorf("%s: %w", op, err)
	}

	return accessToken, refreshToken, nil
}

func (a *AuthUseCase) VerifyEmail(ctx context.Context, email, code, fingerprint string) (accessToken, refreshToken string, err error) {
	logrus.WithFields(logrus.Fields{"email": email, "code": code}).Trace("verifying user's email")
	const op string = "usecase.VerifyEmail"

	verifData, err := a.verifRepo.GetVerificationData(ctx, email)
	if err != nil {
		return "", "", apperr.SystemError(err, op, "failed to get verification data")
	}

	if code != verifData.Code {
		return "", "", apperr.ErrInvalidVerifCode
	}

	if time.Now().After(verifData.ExpiresAt) {
		return "", "", apperr.ErrVerifCodeExpired
	}

	err = a.userRepo.VerifyEmail(ctx, email)
	if err != nil {
		return "", "", apperr.SystemError(err, op, "failed to verify email")
	}

	err = a.verifRepo.DeleteVerificationData(ctx, email)
	if err != nil {
		return "", "", apperr.SystemError(err, op, "failed to delete verification data")
	}

	user, err := a.userRepo.GetUserByEmail(ctx, email)
	if err != nil {
		return "", "", apperr.SystemError(err, op, "failed to get user by email")
	}

	accessToken, refreshToken, err = a.GenerateTokenPair(ctx, user.ID, fingerprint, a.accessTokenTTL, a.refreshTokenTTL)
	if err != nil {
		return "", "", err
	}

	return accessToken, refreshToken, nil
}

func (a *AuthUseCase) SendConfirmationCode(ctx context.Context, email string) error {
	logrus.WithField("email", email).Trace("sending confirmation code")
	const op string = "usecase.SendConfirmationCode"

	userExists, err := a.userRepo.UserExists(ctx, email)
	if err != nil {

		return apperr.SystemError(err, op, "failed to check if user exists")
	}

	if userExists {
		verified, err := a.userRepo.UserVerified(ctx, email)
		if err != nil {
			return apperr.SystemError(err, op, "failed to verify user's email")
		}

		if verified {
			return a.sendEmail(email, "", EmailExistsMessage)
		}
	} else {
		return apperr.ErrNotFound
	}

	code := a.generateCode()
	err = a.sendEmail(email, code, ConfirmationMessage)
	if err != nil {

		return apperr.ErrSendingEmail.WithErr(err)
	}

	exists, err := a.verifRepo.VerificationDataExists(ctx, email)
	if err != nil {
		return apperr.SystemError(err, op, "failed to check if verification data exists")
	}

	verifData := entity.VerificationData{
		Email:     email,
		Code:      code,
		CreatedAt: time.Now(),
		ExpiresAt: time.Now().Add(a.verifCodeTTL),
	}
	if exists {
		err = a.verifRepo.UpdateVerificationDataCode(ctx, verifData)
		if err != nil {
			return apperr.SystemError(err, op, "failed to update verification data code")
		}
	} else {
		err = a.verifRepo.CreateVerificationData(ctx, verifData)
		if err != nil {
			return apperr.SystemError(err, op, "failed to create verification data")
		}
	}

	return nil
}

func (a *AuthUseCase) ParseToken(accessToken string) (jwt.MapClaims, error) {
	logrus.WithField("token", accessToken).Trace("parsing jwt-token")
	const op string = "usecase.ParseToken"

	token, err := jwt.Parse(accessToken, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			logrus.WithField("alg", t.Header["alg"]).Error("unexpected signing method")
			return nil, apperr.SystemError(nil, op, "unexpected signing method")
		}
		return []byte(a.signingKey), nil
	})

	if err != nil {

		return nil, apperr.ErrInvalidAuthHeader.WithErr(err)
	}

	payload, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return nil, apperr.SystemError(nil, op, "claims are not of type jwt.MapClaims")
	}

	return payload, nil
}

func (a *AuthUseCase) GenerateAccessToken(id string, tokenTTL time.Duration) (string, error) {
	logrus.WithField("id", id).Trace("generating access token")
	const op string = "usecase.GenerateAccessToken"

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"ueid": id,
		"iat":  time.Now().Unix(),
		"exp":  time.Now().Add(tokenTTL).Unix(),
	})

	signedToken, err := token.SignedString([]byte(a.signingKey))
	if err != nil {
		logrus.WithError(err).Error("failed to sign token")

		return "", apperr.SystemError(err, op, "failed to sign token")
	}

	return signedToken, nil
}

func (a *AuthUseCase) GenerateRefreshToken(ctx context.Context, userID, fingerprint string, tokenTTL time.Duration) (string, error) {
	logrus.WithFields(logrus.Fields{"userID": userID, "fingerprint": fingerprint}).Trace("generating refresh token")
	const op string = "usecase.GenerateRefreshToken"

	refreshSession := entity.RefreshSession{
		UserID:      userID,
		Fingerprint: fingerprint,
		IssuedAt:    time.Now(),
		Expiration:  time.Now().Add(tokenTTL),
	}
	refreshToken, err := a.refreshRepo.CreateRefreshSession(ctx, refreshSession)
	if err != nil {
		return "", apperr.SystemError(err, op, "failed to create refresh session")
	}

	return refreshToken, nil
}

func (a *AuthUseCase) GenerateTokenPair(ctx context.Context, userID, fingerprint string, accesstokenTTL, refreshtokenTTL time.Duration) (accessToken, refreshToken string, err error) {
	logrus.WithFields(logrus.Fields{"userID": userID, "fingerprint": fingerprint}).Trace("generating token pair")
	const op string = "usecase.GenerateTokenPair"

	accesstoken, err := a.GenerateAccessToken(userID, accesstokenTTL)
	if err != nil {
		return "", "", fmt.Errorf("%s: %w", op, err)
	}

	refreshToken, err = a.GenerateRefreshToken(ctx, userID, fingerprint, refreshtokenTTL)
	if err != nil {
		return "", "", fmt.Errorf("%s: %w", op, err)
	}

	return accesstoken, refreshToken, nil
}

func (a *AuthUseCase) sendEmail(email, code string, emailType int) error {
	logrus.WithFields(logrus.Fields{"email": email, "code": code}).Trace("sending email")
	const op string = "usecase.sendEmail"

	m := gomail.NewMessage()
	m.SetHeaders(map[string][]string{
		"From": {a.emailFrom},
		"To":   {email},
	})

	var body bytes.Buffer
	var err error
	switch emailType {
	case ConfirmationMessage:
		m.SetHeader("Subject", "Код подтверждения")
		err = tmplConfirm.Execute(&body, struct{ Code string }{Code: code})
	case EmailExistsMessage:
		m.SetHeader("Subject", "Попытка регистрации с вашей почтой в Habit Tracker")
		err = tmplEmailExists.Execute(&body, struct{ Code string }{Code: code})
	}
	if err != nil {

		return apperr.SystemError(err, op, "failed to execute html-template")
	}

	m.SetBody("text/html", body.String())

	err = sender.Send(a.emailFrom, []string{email}, m)
	if err != nil {

		return apperr.ErrSendingEmail.WithErr(err)
	}

	return nil
}

func (a *AuthUseCase) hashPassword(password string) string {
	hash := sha256.New()
	hash.Write([]byte(password))

	return fmt.Sprintf("%x", hash.Sum([]byte(a.salt)))
}

func (a *AuthUseCase) generateCode() string {
	return fmt.Sprintf("%04d", rand.Intn(10000))
}
