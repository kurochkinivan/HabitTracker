package apperr

import (
	"encoding/json"
	"net/http"
)

type AppError struct {
	Err        error  `json:"-"`
	ErrMessage string `json:"err_message,omitempty"`
	Message    string `json:"user_message,omitempty"`
	DevMessage string `json:"dev_message,omitempty"`
	Code       string `json:"code,omitempty"`
	HttpCode   int    `json:"-"`
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

func (e *AppError) Marshal() []byte {
	data, err := json.Marshal(e)
	if err != nil {
		return nil
	}
	return data
}

func SystemError(err error, msg, devMsg string) *AppError {
	if msg == "" {
		msg = "internal server error"
	}
	errMessage := ""
	if err != nil {
		errMessage = err.Error()
	}
	return NewAppErr(err, errMessage, msg, devMsg, "US-000", http.StatusInternalServerError)
}

func NewAppErr(err error, errMessage, msg, devMsg, code string, httpCode int) *AppError {
	return &AppError{
		Err:        err,
		ErrMessage: errMessage,
		Message:    msg,
		DevMessage: devMsg,
		Code:       code,
		HttpCode: httpCode,
	}
}
