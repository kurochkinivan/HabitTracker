-- Active: 1739282930250@@127.0.0.1@30000@habit_tracker
DROP TABLE IF EXISTS verification_data;
DROP TABLE IF EXISTS refresh_sessions;
DROP TABLE IF EXISTS habit_notifications;
DROP TABLE IF EXISTS habit_schedules;
DROP TABLE IF EXISTS habit_days;
DROP TABLE IF EXISTS habits;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS days_of_week;

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

-- Icons у Игоря хранятся, а у меня текстовое имя файла
-- поле active - привычка активная/неактивная
-- TODO: popularity index, icon, color (HEX - добавить ff перед кодом цвета и убрать #);
-- TODO: category table ??
-- TODO: think about default habits, categories (maybe field custom/default)
CREATE TABLE IF NOT EXISTS categories (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS habits (
    id INT GENERATED ALWAYS AS IDENTITY,
    user_id UUID NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    category_id INT NOT NULL,
    interval TEXT NOT NULL,
    popularity_index NUMERIC(5, 2),
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id),
    CONSTRAINT check_interval CHECK (interval IN ('daily', 'weekly', 'custom')),
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES categories(id),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS days_of_week (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS habit_schedules (
    id INT GENERATED ALWAYS AS IDENTITY,
    habit_id INT NOT NULL,
    day_id INT NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_habit_id FOREIGN KEY (habit_id) REFERENCES habits(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_day_id FOREIGN KEY (day_id) REFERENCES days_of_week(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE(habit_id, day_id)
);

-- TODO: Сделать первичный ключ составным 
CREATE TABLE IF NOT EXISTS habit_notifications (
    id INT GENERATED ALWAYS AS IDENTITY,
    habit_id INT NOT NULL,
    notification_time TIME NOT NULL, 
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY(id),
    CONSTRAINT fk_habit_id FOREIGN KEY (habit_id) REFERENCES habits(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);