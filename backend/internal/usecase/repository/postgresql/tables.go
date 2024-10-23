package postgresql

// The database schema to be used.
const scheme = "public."

// The names of tables in the database.
const (
	usersTable            = scheme + "users"
	verificationDataTable = scheme + "verification_data"
)
