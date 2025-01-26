package v1

import (
	"encoding/json"
	"net/http"

	"github.com/julienschmidt/httprouter"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
)

type habitHandler struct {
	h          usecase.Habit
	signingKey string
}

func NewHabitHandler(habit usecase.Habit, signingKey string) Handler {
	return &habitHandler{
		h:          habit,
		signingKey: signingKey,
	}
}

func (h *habitHandler) Register(r *httprouter.Router) {
	r.GET("/v1/users/:id/habits", errMdw(authMdw(logMdw(h.getHabits), h.signingKey)))
}

func (h *habitHandler) getHabits(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.getHabits"

	paramsID := p.ByName("id")
	userID := r.Header.Get("user_id")

	if paramsID != userID {
		return apperr.ErrUnauthorized
	}

	habits, err := h.h.GetUserHabits(r.Context(), paramsID)
	if err != nil {
		return apperr.SystemError(err, op, "failed to get all habits")
	}

	resp, err := json.Marshal(habits)
	if err != nil {
		return apperr.ErrSerializeData
	}

	w.Write(resp)

	return nil
}
