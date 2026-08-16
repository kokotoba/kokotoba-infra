CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    text_size TEXT NOT NULL DEFAULT '大きい',
    button_size TEXT NOT NULL DEFAULT '大きい',
    contrast TEXT NOT NULL DEFAULT '標準',
    suggestion_count INTEGER NOT NULL DEFAULT 3 CHECK (suggestion_count > 0),
    speech_rate TEXT NOT NULL DEFAULT '標準',
    speech_volume INTEGER NOT NULL DEFAULT 80
        CHECK (speech_volume BETWEEN 0 AND 100),
    speech_voice TEXT NOT NULL DEFAULT '日本語 1',
    use_history_for_suggestions BOOLEAN NOT NULL DEFAULT TRUE,
    use_location_for_suggestions BOOLEAN NOT NULL DEFAULT FALSE,
    use_profile_for_suggestions BOOLEAN NOT NULL DEFAULT TRUE,
    show_confirmation_after_selection BOOLEAN NOT NULL DEFAULT TRUE,
    save_conversation_history BOOLEAN NOT NULL DEFAULT TRUE,
    allow_external_communication BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name) VALUES ('デモユーザー');
