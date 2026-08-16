ALTER TABLE users
    ADD COLUMN firebase_uid TEXT;

ALTER TABLE users
    ADD CONSTRAINT users_firebase_uid_not_blank
    CHECK (firebase_uid IS NULL OR BTRIM(firebase_uid) <> ''),
    ADD CONSTRAINT users_firebase_uid_unique UNIQUE (firebase_uid);
