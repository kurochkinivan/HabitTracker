package v1

import (
	"encoding/json"
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

func (a *authHandler) Register(mux *http.ServeMux) {
	mux.HandleFunc(http.MethodPost+" /auth/register", errMdw(logMdw(a.registerUser)))
	mux.HandleFunc(http.MethodPost+" /auth/login", errMdw(logMdw(a.loginUser)))
}

type registerRequest struct {
	Name     string `json:"name"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

//	@Summary		Register user
//	@Description	register new user
//	@Tags			auth
//	@Accept			json
//	@Produce		json
//	@Success		201
//	@Failure		400	
//	@Router			/auth/register [post]
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

	err = h.auth.RegisterUser(r.Context(), req.Name, req.Email, req.Password)
	if err != nil {
		return err
	}

	w.WriteHeader(http.StatusCreated)

	return nil
}

type loginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}
type loginResponse struct {
	JWT string `json:"jwt"`
}

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
