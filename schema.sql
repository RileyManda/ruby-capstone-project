-- create database cataglog
CREATE DATABASE IF NOT EXISTS things_db;

-- Create the Genre table
CREATE TABLE genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
);

-- Create the Item table
CREATE TABLE item (
    id SERIAL PRIMARY KEY,
    genre VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    source VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL,
    public_date DATE(255) NOT NULL,
    archived BOOLEAN(255) NOT NULL,
    can_be_archived BOOLEAN(255) NOT NULL,
    genre_id INT REFERENCES genres(id)
);

-- create table music_album

CREATE TABLE music_album (
    id SERIAL PRIMARY KEY,
    can_be_archived BOOLEAN(255) NOT NULL,
    on_spotify BOOLEAN,
    item_id INT REFERENCES items(id)
);

ALTER TABLE item ADD CONSTRAINT unique_item UNIQUE (id);

-- create table books

CREATE TABLE books (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    publisher VARCHAR(255),
    cover_state VARCHAR(255),
    publish_date DATE,
    FOREIGN KEY (id) REFERENCES items(id)
);

-- create table labels

CREATE TABLE labels (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255),
    color VARCHAR(255),
)

-- create table games

CREATE TABLE games (
    id INT PRIMARY KEY,
    last_played_at TIMESTAMP,
    multiplayer BOOLEAN,
    FOREIGN KEY (id) REFERENCES items(id)
);

-- create table authors

CREATE TABLE authors (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    item_id INT,
    FOREIGN KEY (item_id) REFERENCES items(id)
);