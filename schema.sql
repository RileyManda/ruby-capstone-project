-- create database cataglog
CREATE DATABASE IF NOT EXISTS catalog;

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
    publish_date DATE(255) NOT NULL,
    archived BOOLEAN(255) NOT NULL,
    can_be_archived BOOLEAN(255) NOT NULL,
    genre_id INT REFERENCES genre(id)
);

-- create table music_album

CREATE TABLE music_album (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  publish_date DATE,
  on_spotify BOOLEAN,
  archived BOOLEAN,
  genre_id INT REFERENCES genre(id),
  author_id INT REFERENCES author(id),
  label_id INT REFERENCES label(id)
);


-- create table books

CREATE TABLE book (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	publisher VARCHAR(100),
	cover_state VARCHAR(100)
	publish_date  DATE
	archived Boolean
	genre_id INT REFERENCES genre(id),
  	author_id INT REFERENCES author(id),
  	label_id INT REFERENCES label(id),
);

-- create table labels

CREATE TABLE label (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255),
    color VARCHAR(255),
)

-- create table games

CREATE TABLE game (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  archived BOOLEAN,
  multiplayer BOOLEAN,
  publish_date DATE,
  last_played_at DATE,
  genre_id INT REFERENCES genre(id),
  author_id INT REFERENCES author(id),
  label_id INT REFERENCES label(id)
);

-- create table authors

CREATE TABLE author (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    item_id INT,
);