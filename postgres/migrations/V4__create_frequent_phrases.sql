CREATE TABLE frequent_phrases (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    text TEXT NOT NULL CHECK (BTRIM(text) <> '' AND CHAR_LENGTH(text) <= 500),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, text)
);

CREATE INDEX frequent_phrases_user_created_idx
    ON frequent_phrases (user_id, created_at DESC);
