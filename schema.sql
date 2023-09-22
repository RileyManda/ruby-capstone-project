-- create database catalog
CREATE DATABASE IF NOT EXISTS catalog;

-- Create the Genre table
CREATE TABLE genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create the Item table
CREATE TABLE item (
    id SERIAL PRIMARY KEY,
    genre_id INT REFERENCES genre(id),
    author VARCHAR(255) NOT NULL,
    source VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL,
    publish_date DATE NOT NULL,
    archived BOOLEAN NOT NULL
);

-- Create the MusicAlbum table
CREATE TABLE music_album (
    id SERIAL PRIMARY KEY,
    publish_date DATE,
    on_spotify BOOLEAN,
    archived BOOLEAN,
    genre_id INT REFERENCES genre(id),
    author VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL
);

-- Create the Book table
CREATE TABLE book (
    id SERIAL PRIMARY KEY,
    publisher VARCHAR(100),
    cover_state VARCHAR(100),
    publish_date DATE,
    archived BOOLEAN,
    genre_id INT REFERENCES genre(id),
    author VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL
);

-- Create the Label table
CREATE TABLE label (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    color VARCHAR(255)
);

-- Create the Game table
CREATE TABLE game (
    id SERIAL PRIMARY KEY,
    archived BOOLEAN,
    multiplayer BOOLEAN,
    publish_date DATE,
    last_played_at DATE,
    genre_id INT REFERENCES genre(id),
    author VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL
);

-- Create the Author table
CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    item_id INT
);
