-- Active: 1731585563391@@127.0.0.1@30000@habit_tracker
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS verification_data;
DROP TABLE IF EXISTS refresh_sessions;
DROP TABLE IF EXISTS habits;

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

-- TODO: popularity index, icon, color (HEX - добавить ff перед кодом цвета и убрать #);
-- TODO: category table ??
-- TODO: think about default habits, categories (maybe field custom/default)
CREATE TABLE IF NOT EXISTS habits (
    id INT GENERATED ALWAYS AS IDENTITY,
    user_id UUID NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT,
    interval TEXT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT check_interval CHECK (interval IN ('daily', 'weekly', 'custom')),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS habit_notifications (
    id INT GENERATED ALWAYS AS IDENTITY,
    habit_id INT NOT NULL,
    notification_time TIME NOT NULL, 
    PRIMARY KEY(id),
    CONSTRAINT fk_habit_id FOREIGN KEY (habit_id) REFERENCES habits(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS habit_days (
    id INT GENERATED ALWAYS AS IDENTITY,
    Monday boolean NOT NULL DEFAULT FALSE,
    Tuesday boolean NOT NULL DEFAULT FALSE,
    Wednesday boolean NOT NULL DEFAULT FALSE,
    Thursday boolean NOT NULL DEFAULT FALSE,
    Friday boolean NOT NULL DEFAULT FALSE,
    Saturday boolean NOT NULL DEFAULT FALSE,
    Sunday boolean NOT NULL DEFAULT FALSE,
    PRIMARY KEY(id),
    CONSTRAINT fk_habit_id FOREIGN KEY (id) REFERENCES habits(id)
        ON DELETE CASCADE ON UPDATE CASCADE
)