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

// TODO: change this logic, it should not be here and it should depend on config prod/local
func init() {
	tmplConfirm = template.Must(template.ParseFiles("../../static/html/confirmation_email.html"))
	tmplEmailExists = template.Must(template.ParseFiles("../../static/html/email_already_exists.html"))
	// tmplConfirm = template.Must(template.ParseFiles("confirmation_email.html"))
	// tmplEmailExists = template.Must(template.ParseFiles("email_already_exists.html"))
	dialer := gomail.NewDialer("smtp.gmail.com", 587, "ivan.kurochkin.084@gmail.com", "vwapfrlhzqpglpec")
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
	logrus.WithFields(logrus.Fields{"name": name, "email": email}).Debug("registering new user")
	const op string = "AuthUseCase.RegisterUser"

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
		return fmt.Errorf("%s: %w", op, err)
	}

	return nil
}

func (a *AuthUseCase) LoginUser(ctx context.Context, email, password, fingerprint string) (string, string, error) {
	logrus.WithField("email", email).Debug("logging user in")
	const op string = "AuthUseCase.LoginUser"

	userID, err := a.userRepo.AuthenticateUser(ctx, email, a.hashPassword(password))
	if err != nil {
		return "", "", apperr.SystemError(err, op, "failed to authenticate user")
	}
	if userID == "" {
		return "", "", apperr.ErrAuthorizing
	}

	accessToken, refreshToken, err := a.GenerateTokenPair(ctx, userID, fingerprint)
	if err != nil {
		return "", "", fmt.Errorf("%s: %w", op, err)
	}

	return accessToken, refreshToken, nil
}

func (a *AuthUseCase) VerifyEmail(ctx context.Context, email, code, fingerprint string) (accessToken, refreshToken string, err error) {
	logrus.WithFields(logrus.Fields{"email": email, "code": code}).Debug("verifying user's email")
	const op string = "AuthUseCase.VerifyEmail"

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

	accessToken, refreshToken, err = a.GenerateTokenPair(ctx, user.ID, fingerprint)
	if err != nil {
		return "", "", err
	}

	return accessToken, refreshToken, nil
}

func (a *AuthUseCase) SendConfirmationCode(ctx context.Context, email string) error {
	logrus.WithField("email", email).Debug("sending confirmation code")
	const op string = "AuthUseCase.SendConfirmationCode"

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
			err = a.sendEmail(email, "", EmailExistsMessage)
			if err != nil {
				return fmt.Errorf("%s: %w", op, err)
			}
			return nil
		}
	} else {
		return apperr.ErrNotFound
	}

	code := a.generateCode()
	err = a.sendEmail(email, code, ConfirmationMessage)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
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

func (a *AuthUseCase) LogoutUser(ctx context.Context, refreshToken string) error {
	logrus.WithField("refresh_token", refreshToken).Debug("logging user out")
	const op string = "authUseCase.LogoutUser"
	
	err := a.refreshRepo.DeleteRefreshSessionByToken(ctx, refreshToken)
	if err != nil {
		return apperr.SystemError(err, op, "failed to delete refresh session")
	}

	return nil 
}

func (a *AuthUseCase) RefreshTokens(ctx context.Context, userID, refreshTkn, fingerprint string) (accessToken string, refreshToken string, err error) {
	logrus.WithFields(logrus.Fields{"refresh_token": refreshTkn, "fingerprint": fingerprint}).Debug("refreshing tokens")
	const op string = "AuthUseCase.RefreshTokens"

	refreshSession, err := a.refreshRepo.GetRefreshSession(ctx, refreshTkn)
	if err != nil {
		return "", "", apperr.SystemError(err, op, "failed to get refresh session")
	}
	if refreshSession == (entity.RefreshSession{}) {
		return "", "", apperr.ErrInvalidRefreshToken
	}

	err = a.refreshRepo.DeleteRefreshSessionByToken(ctx, refreshTkn)
	if err != nil {
		return "", "", apperr.SystemError(err, op, "failed to delete refresh session by refresh token")
	}

	if refreshSession.Expiration.Before(time.Now()) {
		return "", "", apperr.ErrTokenExired
	}

	if refreshSession.Fingerprint != fingerprint {
		return "", "", apperr.ErrInvalidFingerprint
	}

	accessToken, refreshToken, err = a.GenerateTokenPair(ctx, userID, fingerprint)
	if err != nil {
		return "", "", fmt.Errorf("%s: %w", op, err)
	}

	return accessToken, refreshToken, nil
}

func (a *AuthUseCase) GenerateTokenPair(ctx context.Context, userID, fingerprint string) (accessToken, refreshToken string, err error) {
	logrus.WithFields(logrus.Fields{"userID": userID, "fingerprint": fingerprint}).Debug("generating token pair")
	const op string = "AuthUseCase.GenerateTokenPair"

	accesstoken, err := a.GenerateAccessToken(userID)
	if err != nil {
		return "", "", fmt.Errorf("%s: %w", op, err)
	}

	refreshToken, err = a.GenerateRefreshToken(ctx, userID, fingerprint)
	if err != nil {
		return "", "", fmt.Errorf("%s: %w", op, err)
	}

	return accesstoken, refreshToken, nil
}

func (a *AuthUseCase) GenerateAccessToken(userID string) (string, error) {
	logrus.WithField("id", userID).Debug("generating access token")
	const op string = "AuthUseCase.GenerateAccessToken"

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"ueid": userID,
		"iat":  time.Now().Unix(),
		"exp":  time.Now().Add(a.accessTokenTTL).Unix(),
	})

	signedToken, err := token.SignedString([]byte(a.signingKey))
	if err != nil {
		logrus.WithError(err).Error("failed to sign token")

		return "", apperr.SystemError(err, op, "failed to sign token")
	}

	return signedToken, nil
}

func (a *AuthUseCase) GenerateRefreshToken(ctx context.Context, userID, fingerprint string) (string, error) {
	logrus.WithFields(logrus.Fields{"userID": userID, "fingerprint": fingerprint}).Debug("generating refresh token")
	const op string = "AuthUseCase.GenerateRefreshToken"

	count, err := a.refreshRepo.CountRefreshSessions(ctx, userID)
	if err != nil {
		return "", apperr.SystemError(err, op, "failed to count refresh sessions")
	}

	if count >= 5 {
		err = a.refreshRepo.DeleteRefreshSessionsByUserID(ctx, userID)
		if err != nil {
			return "", apperr.SystemError(err, op, "failed to delete refresh sessions")
		}
	}

	exists, err := a.refreshRepo.RefreshSessionExists(ctx, fingerprint)
	if err != nil {
		return "", apperr.SystemError(err, op, "failed to check if refresh session exists")
	}

	if exists {
		err = a.refreshRepo.DeleteRefreshSessionByFingerprint(ctx, fingerprint)
		if err != nil {
			return "", apperr.SystemError(err, op, "failed to delete refresh session by fingerprint")
		}
	}

	refreshSession := entity.RefreshSession{
		UserID:      userID,
		Fingerprint: fingerprint,
		IssuedAt:    time.Now(),
		Expiration:  time.Now().Add(a.refreshTokenTTL),
	}
	refreshToken, err := a.refreshRepo.CreateRefreshSession(ctx, refreshSession)
	if err != nil {
		return "", apperr.SystemError(err, op, "failed to create refresh session")
	}

	return refreshToken, nil
}

func (a *AuthUseCase) sendEmail(email, code string, emailType int) error {
	logrus.WithFields(logrus.Fields{"email": email, "code": code}).Debug("sending email")
	const op string = "AuthUseCase.sendEmail"

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
		return apperr.ErrSendingEmail.WithErr(fmt.Errorf("%s: %w", op, err))
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
