-- Active: 1729826532342@@127.0.0.1@30000@habit_tracker
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS verification_data;
DROP TABLE IF EXISTS refresh_sessions;

CREATE TABLE IF NOT EXISTS users (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    is_verified BOOLEAN NOT NULL DEFAULT false,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS verification_data (
	id INT GENERATED ALWAYS AS IDENTITY,
    email TEXT NOT NULL,
    code TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    expires_at TIMESTAMPTZ NOT NULL,
    CONSTRAINT fk_user_email FOREIGN KEY (email) REFERENCES users(email)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS refresh_sessions (
    id INT GENERATED ALWAYS AS IDENTITY,
    user_id UUID NOT NULL,
    refresh_token UUID NOT NULL DEFAULT gen_random_uuid(),
    fingerprint TEXT NOT NULL UNIQUE,
    issued_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    expiration TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);