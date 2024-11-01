package apperr

import "net/http"

// US - user service. This is US error.
var (
	ErrNotFound             = NewAppErr(nil, "not found", "entity was not found", "US-001", http.StatusNotFound)
	ErrNotAllFieldsProvided = NewAppErr(nil, "not all fields provided", "user didn't provide all necessary fields", "US-002", http.StatusBadRequest)
)

// VS - validation service. This is VS error.
var (
	ErrValidateData    = NewAppErr(nil, "failed to validate data", "failed to validate data", "VS-001", http.StatusBadRequest)
	ErrSerializeData   = NewAppErr(nil, "failed serialize/desirialize data", "failed serialize/desirialize data", "VS-002", http.StatusBadRequest)
	ErrReadRequestBody = NewAppErr(nil, "failed to read request body", "failed to read request body", "VS-003", http.StatusInternalServerError)
	ErrInvalidUUID     = NewAppErr(nil, "invalid credentials", "client provided invalid UUID", "VS-004", http.StatusBadRequest)
)

// AS - auth server. This is AS error.
var (
	ErrUserExists          = NewAppErr(nil, "the email you have provided is already associated with an account", "user with provided email already exists", "AS-001", http.StatusConflict)
	ErrEmptyAuthHeader     = NewAppErr(nil, "empty auth header", "empty auth header", "AS-002", http.StatusBadRequest)
	ErrInvalidAuthHeader   = NewAppErr(nil, "invalid auth header", "invalid auth header", "AS-003", http.StatusBadRequest)
	ErrTokenExired         = NewAppErr(nil, "token is expired", "provided token is expired", "AS-004", http.StatusUnauthorized)
	ErrAuthorizing         = NewAppErr(nil, "invalid password or email", "user provided wrong email or password", "AS-005", http.StatusUnauthorized)
	ErrSendingEmail        = NewAppErr(nil, "failed to send email", "failed to send email to user", "AS-006", http.StatusInternalServerError)
	ErrInvalidVerifCode    = NewAppErr(nil, "invalid verification code", "user provided invalid verification code", "AS-007", http.StatusUnauthorized)
	ErrVerifCodeExpired    = NewAppErr(nil, "verification code is expired", "verification code is expired", "AS-008", http.StatusUnauthorized)
	ErrInvalidRefreshToken = NewAppErr(nil, "invalid token", "provided token is invalid", "AS-009", http.StatusUnauthorized)
	ErrInvalidFingerprint  = NewAppErr(nil, "invalid fingerprint", "attempt to retrieve token pair from an unrecognized device", "AS-010", http.StatusUnauthorized)
)
