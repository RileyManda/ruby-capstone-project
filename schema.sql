-- create database catalog
CREATE DATABASE IF NOT EXISTS catalog;

-- Create the Genre table
CREATE TABLE genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create table music_album
CREATE TABLE music_album (
    id SERIAL PRIMARY KEY,
    publish_date DATE,
    on_spotify BOOLEAN,
    genre_id INT REFERENCES genre(id),
    author VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL
);

-- Create table books
CREATE TABLE book (
    id SERIAL PRIMARY KEY,
    publisher VARCHAR(100),
    cover_state VARCHAR(100),
    publish_date DATE,
    genre_id INT REFERENCES genre(id),
    author VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL
);

-- Create table labels
CREATE TABLE label (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    color VARCHAR(255)
);

-- Create table games
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

-- Create table authors
CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL
);
