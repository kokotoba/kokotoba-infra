ALTER TABLE frequent_phrases
    ADD COLUMN sort_order BIGINT;

WITH ranked_phrases AS (
    SELECT
        id,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY created_at DESC, id DESC
        ) - 1 AS position
    FROM frequent_phrases
)
UPDATE frequent_phrases AS phrase
SET sort_order = ranked.position
FROM ranked_phrases AS ranked
WHERE phrase.id = ranked.id;

ALTER TABLE frequent_phrases
    ALTER COLUMN sort_order SET NOT NULL;

DROP INDEX frequent_phrases_user_created_idx;

CREATE INDEX frequent_phrases_user_order_idx
    ON frequent_phrases (user_id, sort_order, id);
