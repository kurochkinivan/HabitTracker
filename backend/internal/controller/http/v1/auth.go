package v1

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
)

type authHandler struct {
	auth       usecase.Auth
	bytesLimit int64
}

func NewAuthHandler(a usecase.Auth, bytesLimit int64) Handler {
	return &authHandler{
		auth:       a,
		bytesLimit: bytesLimit,
	}
}

const baseAuthPath = "/v1/auth"

func (a *authHandler) Register(mux *http.ServeMux) {
	mux.HandleFunc(fmt.Sprintf("%s %s/register", http.MethodPost, baseAuthPath), errMdw(logMdw(a.registerUser)))
	mux.HandleFunc(fmt.Sprintf("%s %s/login", http.MethodPost, baseAuthPath), errMdw(logMdw(a.loginUser)))
	mux.HandleFunc(fmt.Sprintf("%s %s/verify-email", http.MethodPost, baseAuthPath), errMdw(logMdw(a.verifyEmail)))
	mux.HandleFunc(fmt.Sprintf("%s %s/get-verification-code", http.MethodPost, baseAuthPath), errMdw(logMdw(a.getVerificationCode)))
}

type (
	registerRequest struct {
		Name     string `json:"name"`
		Email    string `json:"email"`
		Password string `json:"password"`
	}
)

// @Summary		Register user
// @Description	register new user
// @Tags		auth
// @Accept		json
// @Param 		request body v1.registerRequest true "register request parameters"
// @Produce		json
// @Success		200 	"OK. Message was sent to user"
// @Failure		400 	{object}	apperr.AppError		"Bad Request"
// @Failure		500 	{object}	apperr.AppError		"Internal Server Error"
// @Router		/auth/register [post]
func (h *authHandler) registerUser(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")

	data, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(err)
	}
	defer r.Body.Close()

	var req registerRequest
	err = json.Unmarshal(data, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(err)
	}

	if req.Name == "" || req.Email == "" || req.Password == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	err = h.auth.RegisterUser(r.Context(), req.Name, req.Email, req.Password)
	if err != nil {
		return err
	}

	return nil
}

type (
	verifyCodeRequest struct {
		Email string `json:"email"`
		Code  string `json:"code"`
	}

	verifyCodeResponse struct {
		JWT string `json:"jwt"`
	}
)

// @Summary		Verify user's email
// @Description	verify user's email by confirmation code
// @Tags		auth
// @Accept		json
// @Param 		request body v1.verifyCodeRequest true "verify code request parameters"
// @Produce		json
// @Success		200 	{object}	v1.verifyCodeResponse "OK. User was verified"
// @Failure		400 	{object}	apperr.AppError		"Bad Request"
// @Failure		401 	{object}	apperr.AppError		"Unauthorized. User provided invalid verification code"
// @Failure		500 	{object}	apperr.AppError		"Internal Server Error"
// @Router		/auth/verify-email [post]
func (h *authHandler) verifyEmail(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")

	reqData, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(err)
	}
	defer r.Body.Close()

	var req verifyCodeRequest
	err = json.Unmarshal(reqData, &req)
	if err != nil {
		return apperr.ErrSerializeData
	}

	if req.Email == "" || req.Code == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	token, err := h.auth.VerifyEmail(r.Context(), req.Email, req.Code)
	if err != nil {
		return err
	}

	resp := &verifyCodeResponse{
		JWT: token,
	}

	respData, err := json.Marshal(resp)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(err)
	}

	w.Write(respData)

	return nil
}

type (
	loginRequest struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}

	loginResponse struct {
		JWT string `json:"jwt"`
	}
)

// @Summary		Log user in
// @Description	log user in
// @Tags		auth
// @Accept		json
// @Param 		request body v1.loginRequest true "login request parameters"
// @Produce		json
// @Success		200 {object}	v1.loginResponse	"OK. User was logged in"
// @Failure		400 {object}	apperr.AppError		"Bad Request"
// @Failure		401 {object}	apperr.AppError		"Unauthorized. Email or password is incorrect"
// @Failure		500 {object}	apperr.AppError		"Internal Server Error"
// @Router		/auth/login [post]
func (h *authHandler) loginUser(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")

	reqData, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(err)
	}

	var req loginRequest
	err = json.Unmarshal(reqData, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(err)
	}

	if req.Email == "" || req.Password == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	token, err := h.auth.LoginUser(r.Context(), req.Email, req.Password)
	if err != nil {
		return err
	}

	resp := &loginResponse{
		JWT: token,
	}

	respData, err := json.Marshal(resp)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(err)
	}

	w.Write(respData)

	return nil
}

type (
	getVerifCodeRequest struct {
		Email string `json:"email"`
	}
)

// @Summary		Get verification code
// @Description	send verification code to user's email
// @Tags		auth
// @Accept		json
// @Param 		request body v1.getVerifCodeRequest true "getVerifCode request parameters"
// @Produce		json
// @Success		200 "OK. Email with verification code was sent to user"
// @Failure		400 {object}	apperr.AppError		"Bad Request"
// @Failure		404 {object}	apperr.AppError		"Not Found. User with provided email is not signing up"
// @Failure		500 {object}	apperr.AppError		"Internal Server Error"
// @Router		/auth/get-verification-code [post]
func (h *authHandler) getVerificationCode(w http.ResponseWriter, r *http.Request) error {
	w.Header().Set("Content-Type", "application/json")

	reqData, err := io.ReadAll(io.LimitReader(r.Body, h.bytesLimit))
	if err != nil {
		return apperr.ErrReadRequestBody.WithErr(err)
	}

	var req getVerifCodeRequest
	err = json.Unmarshal(reqData, &req)
	if err != nil {
		return apperr.ErrSerializeData.WithErr(err)
	}

	if req.Email == "" {
		return apperr.ErrNotAllFieldsProvided
	}

	err = h.auth.SendConfirmationCode(r.Context(), req.Email)
	if err != nil {
		return err
	}

	return nil
}
