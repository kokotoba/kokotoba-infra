CREATE TABLE user_settings (
    user_id BIGINT PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
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

INSERT INTO user_settings (
    user_id,
    text_size,
    button_size,
    contrast,
    suggestion_count,
    speech_rate,
    speech_volume,
    speech_voice,
    use_history_for_suggestions,
    use_location_for_suggestions,
    use_profile_for_suggestions,
    show_confirmation_after_selection,
    save_conversation_history,
    allow_external_communication,
    created_at,
    updated_at
)
SELECT
    id,
    text_size,
    button_size,
    contrast,
    suggestion_count,
    speech_rate,
    speech_volume,
    speech_voice,
    use_history_for_suggestions,
    use_location_for_suggestions,
    use_profile_for_suggestions,
    show_confirmation_after_selection,
    save_conversation_history,
    allow_external_communication,
    created_at,
    updated_at
FROM users;

CREATE FUNCTION create_default_user_settings()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO user_settings (user_id) VALUES (NEW.id);
    RETURN NEW;
END;
$$;

CREATE TRIGGER users_create_default_settings
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION create_default_user_settings();

ALTER TABLE users
    DROP COLUMN text_size,
    DROP COLUMN button_size,
    DROP COLUMN contrast,
    DROP COLUMN suggestion_count,
    DROP COLUMN speech_rate,
    DROP COLUMN speech_volume,
    DROP COLUMN speech_voice,
    DROP COLUMN use_history_for_suggestions,
    DROP COLUMN use_location_for_suggestions,
    DROP COLUMN use_profile_for_suggestions,
    DROP COLUMN show_confirmation_after_selection,
    DROP COLUMN save_conversation_history,
    DROP COLUMN allow_external_communication;
