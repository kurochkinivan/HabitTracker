package v1

import (
	"encoding/json"
	"io"
	"net/http"

	"github.com/kurochkinivan/HabitTracker/internal/usecase"
)

type authHandler struct {
	auth usecase.Auth
	bytesLimit int64
}


func NewAuthHandler(a usecase.Auth, bytesLimit int64) Handler {
	return &authHandler{
		auth: a,
		bytesLimit: bytesLimit,
	}
}

func (a *authHandler) Register(mux *http.ServeMux) {
	mux.HandleFunc(http.MethodPost+" /auth/register", a.registerUser)
	mux.HandleFunc(http.MethodPost+" /auth/login", a.loginUser)
}

type registerRequest struct {
	Name     string `json:"name"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

func (h *authHandler) registerUser(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	io.LimitReader(r.Body, 1024)
	data, err := io.ReadAll(r.Body)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	defer r.Body.Close()

	var req registerRequest
	err = json.Unmarshal(data, &req)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	err = h.auth.RegisterUser(r.Context(), req.Name, req.Email, req.Password)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

type loginRequest struct {
	Email    string `json:"name"`
	Password string `json:"password"`
}

func (h *authHandler) loginUser(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

}
