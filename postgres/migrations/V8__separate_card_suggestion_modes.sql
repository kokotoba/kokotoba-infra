ALTER TABLE card_suggestions
    ADD COLUMN generation_mode TEXT NOT NULL DEFAULT 'fast'
    CHECK (generation_mode IN ('fast', 'quality'));

ALTER TABLE card_selection_history
    ADD COLUMN generation_mode TEXT NOT NULL DEFAULT 'fast'
    CHECK (generation_mode IN ('fast', 'quality'));

CREATE INDEX card_selection_history_mode_selected_idx
    ON card_selection_history (generation_mode, selected_at DESC);
