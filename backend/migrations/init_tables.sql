-- Active: 1728368916919@@127.0.0.1@30000@habit_tracker
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS verification_data;

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
