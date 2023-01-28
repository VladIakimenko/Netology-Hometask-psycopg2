CREATE TABLE IF NOT EXISTS genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS artists_genres (
    relationship_id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL REFERENCES artists(artist_id),
    genre_id INTEGER NOT NULL REFERENCES genres(genre_id)
);
CREATE TABLE IF NOT EXISTS albums (
    album_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    release_date DATE
);
CREATE TABLE IF NOT EXISTS albums_artists (
    relationship_id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL REFERENCES artists(artist_id),
    album_id INTEGER NOT NULL REFERENCES albums(album_id)
);
CREATE TABLE IF NOT EXISTS tracks (
    track_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    duration TIME NOT NULL,
    release_date DATE,
    album_id INTEGER NOT NULL REFERENCES albums(album_id)
);
CREATE TABLE IF NOT EXISTS mixes (
    mix_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    release_date DATE
);
CREATE TABLE IF NOT EXISTS tracks_mixes (
    relationship_id SERIAL PRIMARY KEY,
    track_id INTEGER NOT NULL REFERENCES tracks(track_id),
    mix_id INTEGER NOT NULL REFERENCES mixes(mix_id)
);