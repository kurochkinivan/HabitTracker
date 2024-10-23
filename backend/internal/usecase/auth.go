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
	tmplConfirm, tmplEmailExists *template.Template
	sender                       gomail.SendCloser
)

const (
	ConfirmationMessage = iota
	EmailExistsMessage
)

func init() {
	// tmplConfirm = template.Must(template.ParseFiles("../../static/html/confirmation_email.html"))
	// tmplEmailExists = template.Must(template.ParseFiles("../../static/html/email_already_exists.html"))
	tmplConfirm = template.Must(template.ParseFiles("confirmation_email.html"))
	tmplEmailExists = template.Must(template.ParseFiles("email_already_exists.html"))
	dialer := gomail.NewDialer("smtp.gmail.com", 587, "ivan.kurochkin.084@gmail.com", "hiqecckzffwewzqc")
	var err error
	sender, err = dialer.Dial()
	if err != nil {
		logrus.Fatal(err)
	}
}

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

	exists, err := a.userRepo.IsUserExistsAndVerified(ctx, user.Email)
	if err != nil {
		return apperr.SystemError(err, "", fmt.Sprintf("%s: failed to check if user exists", op))
	}
	if exists {
		go func() {
			err = a.SendEmail(user.Email, "", EmailExistsMessage)
			if err != nil {
				logrus.WithError(err).Error("failed to send email")
			}
		}()
		return nil
	}

	err = a.userRepo.CreateUser(ctx, user)
	if err != nil {
		return apperr.SystemError(err, "", fmt.Sprintf("%s: failed to create user", op))
	}

	go func() {
		code := a.generateCode()
		err = a.SendEmail(user.Email, code, ConfirmationMessage)
		if err != nil {
			logrus.WithError(err).Error("failed to send email")
		}

		err = a.verifRepo.CreateVerificationData(context.TODO(), user.Email, code)
		if err != nil {
			logrus.WithError(err).Error(fmt.Sprintf("%s: failed to create verification data", op))
		}
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

func (a *AuthUseCase) VerifyEmail(ctx context.Context, email, code string) (string, error) {
	logrus.WithFields(logrus.Fields{"email": email, "code": code}).Trace("verifying user's email")
	const op string = "usecase.VerifyEmail"

	if email == "" || code == "" {
		return "", apperr.ErrNotAllFieldsProvided
	}

	verifData, err := a.verifRepo.GetVerificationData(ctx, email) 
	if err != nil {
		return "", apperr.SystemError(err, "", fmt.Sprintf("%s: failed to get verification data", op))
	}

	if code != verifData.Code {
		return "", apperr.ErrInvalidVerifCode
	}

	err = a.userRepo.VerifyEmail(ctx, email)
	if err != nil {
		return "", apperr.SystemError(err, "", fmt.Sprintf("%s: failed to verify email", op))
	}

	err = a.verifRepo.DeleteVerificationData(ctx, email)
	if err != nil {
		return "", apperr.SystemError(err, "", fmt.Sprintf("%s: failed to delete verification data", op))
	}

	user, err := a.userRepo.GetUserByEmail(ctx, email)
	if err != nil {
		return "", apperr.SystemError(err, "", fmt.Sprintf("%s: failed to get user by email", op))
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

// SendEmail sends a given email to the user with given code.
//
// It checks the type of message to be sent and renders a corresponding HTML-template.
// If the template execution is failed, it returns an error.
// If the template is successfully executed, it sends the message with the rendered HTML-body.
// If the email sending is failed, it returns the error.
// If the email is successfully sent, it returns nil.
func (a *AuthUseCase) SendEmail(email, code string, emailType int) error {
	logrus.WithFields(logrus.Fields{"email": email, "code": code}).Trace("sending email")

	m := gomail.NewMessage()
	m.SetHeaders(map[string][]string{
		"From": {a.email.from},
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
		return apperr.SystemError(err, "", "failed to execute html-template")
	}

	m.SetBody("text/html", body.String())

	err = sender.Send(a.email.from, []string{email}, m)
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
