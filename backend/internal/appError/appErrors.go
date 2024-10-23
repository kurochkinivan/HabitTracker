package apperr

import "net/http"

// US - user service. This is US error.
var (
	ErrNotFound = NewAppErr(nil, "not found", "entity was not found", "US-001", http.StatusNotFound)
	ErrNotAllFieldsProvided = NewAppErr(nil, "not all fields provided", "user didn't provide all necessary fields", "US-002", http.StatusBadRequest)
)

// VS - validation service. This is VS error.
var (
	ErrValidateData = NewAppErr(nil, "failed to validate data", "failed to validate data", "VS-001", http.StatusBadRequest)
	ErrSerializeData = NewAppErr(nil, "failed serialize/desirialize data", "failed serialize/desirialize data", "VS-002", http.StatusBadRequest)
	ErrReadRequestBody = NewAppErr(nil, "failed to read request body", "failed to read request body", "VS-003", http.StatusInternalServerError)
)

// AS - auth server. This is AS error.
var (
	ErrUserExists = NewAppErr(nil, "user with provided email already exists", "user with provided email already exists", "AS-001", http.StatusConflict)
	ErrEmptyAuthHeader = NewAppErr(nil, "empty auth header", "empty auth header", "AS-002", http.StatusBadRequest)
	ErrInvalidAuthHeader = NewAppErr(nil, "invalid auth header", "invalid auth header", "AS-003", http.StatusBadRequest)
	ErrTokenExired = NewAppErr(nil, "access token is expired", "access token is expired", "AS-004", http.StatusUnauthorized)
	ErrAuthorizing = NewAppErr(nil, "invalid password or email", "user provided wrong email or password", "AS-005", http.StatusUnauthorized)
)