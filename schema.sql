-- create database cataglog

CREATE TABLE IF NOT EXISTS `catalog` (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  description varchar(255) NOT NULL,
  created_at datetime NOT NULL,
  updated_at datetime NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- Create the Genre table
CREATE TABLE genres (
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

ALTER TABLE items ADD CONSTRAINT unique_item UNIQUE (id);