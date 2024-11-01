package apperr

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type AppError struct {
	Err        error  `json:"-"`
	ErrMessage string `json:"err_message,omitempty"`
	Message    string `json:"user_message,omitempty"`
	DevMessage string `json:"dev_message,omitempty"`
	Code       string `json:"code,omitempty"`
	HTTPCode   int    `json:"-"`
}

func (e *AppError) Error() string {
	return e.Message
}

func (e *AppError) UnWrap() error {
	return e.Err
}

func (e *AppError) WithErr(err error) *AppError {
	e.Err = err
	return e
}

func (e *AppError) MarshalWithTrace(trace string) []byte {
	if e.Err != nil {
		trace, _ = strings.CutSuffix(trace, ": internal server error")
		e.ErrMessage = fmt.Sprintf("%s: %s", trace, e.Err.Error())
	}
	data, err := json.Marshal(e)
	if err != nil {
		return nil
	}
	return data
}

func SystemError(err error, op, devMsg string) *AppError {
	return NewAppErr(fmt.Errorf("%s: %w", op, err), "internal server error", devMsg, "US-000", http.StatusInternalServerError)
}

func NewAppErr(err error, msg, devMsg, code string, httpCode int) *AppError {
	return &AppError{
		Err:        err,
		Message:    msg,
		DevMessage: devMsg,
		Code:       code,
		HTTPCode:   httpCode,
	}
}
