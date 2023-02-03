CREATE TABLE genres 
(
    PRIMARY KEY (genre_id),
    genre_id    SERIAL,
    genre_name  VARCHAR(60)  NOT NULL  UNIQUE
);

CREATE TABLE artists 
(
    PRIMARY KEY (artist_id),
    artist_id    SERIAL,
    artist_name  VARCHAR(60)  NOT NULL  UNIQUE
);

CREATE TABLE artists_genres 
(
    PRIMARY KEY (relationship_id),
    relationship_id  SERIAL,
    artist_id        INTEGER  NOT NULL  REFERENCES artists(artist_id),
    genre_id         INTEGER  NOT NULL  REFERENCES genres(genre_id)
);

CREATE TABLE albums 
(
    PRIMARY KEY (album_id),
    album_id      SERIAL,
    album_name    VARCHAR(60)  NOT NULL  UNIQUE,
    release_date  DATE,        
                  CONSTRAINT release_date_range
                  CHECK (release_date BETWEEN '1900-01-01' AND current_date)
);

CREATE TABLE albums_artists
(
    PRIMARY KEY (relationship_id),
    relationship_id  SERIAL,
    artist_id        INTEGER  NOT NULL  REFERENCES artists(artist_id),
    album_id         INTEGER  NOT NULL  REFERENCES albums(album_id)
);

CREATE TABLE tracks 
(
    PRIMARY KEY (track_id),
    track_id     SERIAL,
    track_name   VARCHAR(60)  NOT NULL,
    duration     INTEGER      NOT NULL,
                 CONSTRAINT duration_range
                 CHECK (duration BETWEEN 0 AND 10800),
    album_id     INTEGER      NOT NULL  REFERENCES albums(album_id)
);

CREATE TABLE mixes
(
    PRIMARY KEY (mix_id),
    mix_id       SERIAL,
    mix_name     VARCHAR(60)  NOT NULL,
    release_date DATE,        
                 CONSTRAINT release_date_range
                 CHECK (release_date BETWEEN '1900-01-01' AND current_date)
);

CREATE TABLE tracks_mixes 
(
    PRIMARY KEY (relationship_id),
    relationship_id  SERIAL,
    track_id         INTEGER  NOT NULL  REFERENCES tracks(track_id),
    mix_id           INTEGER  NOT NULL  REFERENCES mixes(mix_id)
);

