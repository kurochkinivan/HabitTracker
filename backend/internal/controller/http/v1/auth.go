package v1

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/google/uuid"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
)

type authHandler struct {
	auth       usecase.Auth
	bytesLimit int64
	signingKey string
}

func NewAuthHandler(a usecase.Auth, bytesLimit int64, signingKey string) Handler {
	return &authHandler{
		auth:       a,
		bytesLimit: bytesLimit,
		signingKey: signingKey,
	}
}

const baseAuthPath = "/v1/auth"

func (h *authHandler) Register(mux *http.ServeMux) {
	mux.HandleFunc(fmt.Sprintf("%s %s/register", http.MethodPost, baseAuthPath), errMdw(logMdw(h.registerUser)))
	mux.HandleFunc(fmt.Sprintf("%s %s/login", http.MethodPost, baseAuthPath), errMdw(logMdw(h.loginUser)))
	mux.HandleFunc(fmt.Sprintf("%s %s/verify-email", http.MethodPost, baseAuthPath), errMdw(logMdw(h.verifyEmail)))
	mux.HandleFunc(fmt.Sprintf("%s %s/get-verification-code", http.MethodPost, baseAuthPath), errMdw(logMdw(h.getVerificationCode)))
	mux.HandleFunc(fmt.Sprintf("%s %s/refresh-tokens", http.MethodPost, baseAuthPath), errMdw(logMdw(h.refreshTokens)))
}

type (
	registerRequest struct {
		Name     string `json:"name"`
		Email    string `json:"email"`
		Password string `json:"password"`
	}
)

//	@Summary		Register user
//	@Description	register new user
//	@Tags			auth
//	@Accept			json
//	@Param			request	body	v1.registerRequest	true	"register request parameters"
//	@Produce		json
//	@Success		200	"OK. Message was sent to user"
//	@Failure		400	{object}	apperr.AppError	"Bad Request"
//	@Failure		409	{object}	apperr.AppError	"Conflict. User with provided email already exists"
//	@Failure		500	{object}	apperr.AppError	"Internal Server Error"
//	@Router			/auth/register [post]
func (h *authHandler) registerUser(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "authHandler.registerUser"

	data, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(fmt.Errorf("%s: %w", op, err))
	}
	defer r.Body.Close()

	var req registerRequest
	err = json.Unmarshal(data, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	if req.Name == "" || req.Email == "" || req.Password == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	err = h.auth.RegisterUser(r.Context(), req.Name, req.Email, req.Password)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	return nil
}

type (
	verifyCodeRequest struct {
		Email       string `json:"email"`
		Code        string `json:"code"`
		Fingerprint string `json:"fingerprint"`
	}

	verifyCodeResponse struct {
		AccessToken  string `json:"access_token"`
		RefreshToken string `json:"refresh_token"`
	}
)

//	@Summary		Verify user's email
//	@Description	verify user's email by confirmation code
//	@Tags			auth
//	@Accept			json
//	@Param			request	body	v1.verifyCodeRequest	true	"verify code request parameters"
//	@Produce		json
//	@Success		200	{object}	v1.verifyCodeResponse	"OK. User was verified"
//	@Failure		400	{object}	apperr.AppError			"Bad Request"
//	@Failure		401	{object}	apperr.AppError			"Unauthorized. User provided invalid verification code"
//	@Failure		500	{object}	apperr.AppError			"Internal Server Error"
//	@Router			/auth/verify-email [post]
func (h *authHandler) verifyEmail(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "authHandler.verifyEmail"

	reqData, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(fmt.Errorf("%s: %w", op, err))
	}
	defer r.Body.Close()

	var req verifyCodeRequest
	err = json.Unmarshal(reqData, &req)
	if err != nil {
		return apperr.ErrSerializeData
	}

	if req.Email == "" || req.Code == "" || req.Fingerprint == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	accessToken, refreshToken, err := h.auth.VerifyEmail(r.Context(), req.Email, req.Code, req.Fingerprint)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	resp := &verifyCodeResponse{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
	}

	respData, err := json.Marshal(resp)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	w.Write(respData)

	return nil
}

type (
	loginRequest struct {
		Email       string `json:"email"`
		Password    string `json:"password"`
		Fingerprint string `json:"fingerprint"`
	}

	loginResponse struct {
		AccessToken  string `json:"access_token"`
		RefreshToken string `json:"refresh_token"`
	}
)

//	@Summary		Log user in
//	@Description	log user in
//	@Tags			auth
//	@Accept			json
//	@Param			request	body	v1.loginRequest	true	"login request parameters"
//	@Produce		json
//	@Success		200	{object}	v1.loginResponse	"OK. User was logged in"
//	@Failure		400	{object}	apperr.AppError		"Bad Request"
//	@Failure		401	{object}	apperr.AppError		"Unauthorized. Email or password is incorrect"
//	@Failure		500	{object}	apperr.AppError		"Internal Server Error"
//	@Router			/auth/login [post]
func (h *authHandler) loginUser(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "authHandler.loginUser"

	reqData, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(fmt.Errorf("%s: %w", op, err))
	}
	defer r.Body.Close()

	var req loginRequest
	err = json.Unmarshal(reqData, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	if req.Email == "" || req.Password == "" || req.Fingerprint == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	accessToken, refreshToken, err := h.auth.LoginUser(r.Context(), req.Email, req.Password, req.Fingerprint)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	resp := &loginResponse{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
	}

	respData, err := json.Marshal(resp)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	w.Write(respData)

	return nil
}

type (
	getVerifCodeRequest struct {
		Email string `json:"email"`
	}
)

//	@Summary		Get verification code
//	@Description	send verification code to user's email
//	@Tags			auth
//	@Accept			json
//	@Param			request	body	v1.getVerifCodeRequest	true	"getVerifCode request parameters"
//	@Produce		json
//	@Success		200	"OK. Email with verification code was sent to user"
//	@Failure		400	{object}	apperr.AppError	"Bad Request"
//	@Failure		404	{object}	apperr.AppError	"Not Found. User with provided email is not signing up"
//	@Failure		500	{object}	apperr.AppError	"Internal Server Error"
//	@Router			/auth/get-verification-code [post]
func (h *authHandler) getVerificationCode(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "authHandler.getVerificationCode"

	reqData, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(fmt.Errorf("%s: %w", op, err))
	}
	defer r.Body.Close()

	var req getVerifCodeRequest
	err = json.Unmarshal(reqData, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	if req.Email == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	err = h.auth.SendConfirmationCode(r.Context(), req.Email)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	return nil
}

type (
	refreshTokensRequest struct {
		RefreshToken string `json:"refresh_token"`
		Fingerprint  string `json:"fingerprint"`
		UserID       string `json:"user_id"`
	}

	refreshTokensResponse struct {
		AccessToken  string `json:"access_token"`
		RefreshToken string `json:"refresh_token"`
	}
)

//	@Summary		Refresh tokens
//	@Description	get new access and refresh tokens
//	@Tags			auth
//	@Accept			json
//	@Param			request	body	v1.refreshTokensRequest	true	"refreshTokens request parameters"
//	@Produce		json
//	@Success		200	{object}	v1.refreshTokensResponse	"OK. Tokens were refreshed"
//	@Failure		400	{object}	apperr.AppError				"Bad Request"
//	@Failure		401	{object}	apperr.AppError				"Unauthorized. Request cannot be processed with provided credentials"
//	@Failure		500	{object}	apperr.AppError				"Internal Server Error"
//	@Router			/auth/refresh-tokens [post]
func (h *authHandler) refreshTokens(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "authHandler.refreshTokens"

	reqData, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	var req refreshTokensRequest
	err = json.Unmarshal(reqData, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	if req.RefreshToken == "" || req.Fingerprint == "" || req.UserID == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	if _, err = uuid.Parse(req.UserID); err != nil  {
		return apperr.ErrInvalidUUID 
	}

	if _, err = uuid.Parse(req.RefreshToken); err != nil  {
		return apperr.ErrInvalidUUID 
	}

	accessToken, refreshToken, err := h.auth.RefreshTokens(r.Context(), req.UserID, req.RefreshToken, req.Fingerprint)
	if err != nil {
		return fmt.Errorf("%s: %w", op, err)
	}

	resp := &refreshTokensResponse{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
	}

	respData, err := json.Marshal(resp)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	w.Write(respData)

	return nil
}
