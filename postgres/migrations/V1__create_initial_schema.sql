CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE long_term_memory (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    summary TEXT NOT NULL,
    source_text TEXT NOT NULL,
    embedding vector(384),
    place_name TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    speaker TEXT,
    event_time TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX long_term_memory_embedding_idx
    ON long_term_memory USING hnsw (embedding vector_cosine_ops);

CREATE TABLE tags (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE memory_tag_map (
    memory_id BIGINT NOT NULL REFERENCES long_term_memory(id) ON DELETE CASCADE,
    tag_id BIGINT NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (memory_id, tag_id)
);

CREATE TABLE card_suggestions (
    id TEXT PRIMARY KEY,
    question TEXT NOT NULL,
    location TEXT NOT NULL,
    question_type TEXT NOT NULL,
    cards JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    selected_card_id TEXT,
    selected_at TIMESTAMPTZ
);

CREATE TABLE card_selection_history (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    question TEXT NOT NULL,
    location TEXT NOT NULL,
    shown_cards JSONB NOT NULL,
    selected_card TEXT NOT NULL,
    question_embedding vector(384) NOT NULL,
    selected_at TIMESTAMPTZ NOT NULL
);

CREATE INDEX card_selection_history_embedding_idx
    ON card_selection_history USING hnsw (question_embedding vector_cosine_ops);
