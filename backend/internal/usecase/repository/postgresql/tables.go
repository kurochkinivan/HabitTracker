package postgresql

// The database schema to be used.
const scheme = "public."

// The names of tables in the database.
const (
	TableUsers            = scheme + "users"
	TableVerificationData = scheme + "verification_data"
	TableRefreshSessions  = scheme + "refresh_sessions"
)
