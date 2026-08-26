CREATE TABLE conversation_sessions (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    started_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX conversation_sessions_user_started_idx
    ON conversation_sessions (user_id, started_at DESC);

CREATE UNIQUE INDEX conversation_sessions_user_active_idx
    ON conversation_sessions (user_id)
    WHERE ended_at IS NULL;

CREATE TABLE conversation_utterances (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_id BIGINT NOT NULL
        REFERENCES conversation_sessions(id) ON DELETE CASCADE,
    speaker TEXT NOT NULL CHECK (speaker IN ('partner', 'user')),
    text TEXT NOT NULL CHECK (BTRIM(text) <> '' AND CHAR_LENGTH(text) <= 2000),
    spoken_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX conversation_utterances_session_spoken_idx
    ON conversation_utterances (session_id, spoken_at);