require_relative 'preserve_data'
require 'json'
require 'date'
require_relative 'item'
require_relative 'author'
require_relative 'book'
require_relative 'game_class'
require_relative 'genre'
require_relative 'label'
require_relative 'music_album'
require_relative 'app'

app = App.new

# Store your items
items = []
books = []
music_albums = []
games = []
genres = []
labels = []
authors = []

genres_reader = ReadFile.new('genre.json')
music_albums_reader = ReadFile.new('music_album.json')

music_albums = music_albums_reader.read

# adding book and label methods [START]...............................
def add_book(books, items, authors, labels)
  author = find_or_create_author(authors)
  publisher = input_publisher
  cover_state = input_cover_state
  publish_date = input_publish_date
  label = find_or_create_label(labels)

  book = Book.new(author, publisher, cover_state, publish_date, label)

  items << book
  books << book
  labels << label

  puts 'Book added successfully.'
end

def find_or_create_author(authors)
  puts "Enter author's name: "
  author_name = gets.chomp
  author = authors.find { |a| a.name == author_name }
  author ||= Author.new(author_name)
  authors << author
  author
end

def input_publisher
  print 'Enter publisher: '
  gets.chomp
end

def input_cover_state
  print 'Enter cover state (true or false): '
  gets.chomp.downcase == 'true'
end

def input_publish_date
  print 'Enter publish date (YYYY-MM-DD): '
  Date.parse(gets.chomp)
end

def find_or_create_label(labels)
  print 'Enter label: '
  title = gets.chomp
  print 'Enter color: '
  color = gets.chomp
  label = labels.find { |b| b.title == title && b.color == color }
  label ||= Label.new(title, color)
  label
end
# adding book and label methods [END]...............................

# adding game   [START]...............................
def add_game(games, items)
  puts 'Adding a new game...'
  print 'Enter title: '
  title = gets.chomp
  print 'Enter description: '
  description = gets.chomp
  print 'Enter last played date (YYYY-MM-DD): '
  last_played_at = Date.parse(gets.chomp)
  game = Game.new(title: title, description: description, last_played_at: last_played_at)
  games << game
  items << game
  puts 'Game added successfully.'
end

# adding game   [END]...............................

# adding music_album   [START]......................

def add_music_album(music_albums, items, genres)
  puts 'Adding a new music album...'
  print 'Enter album name: '
  album_name = gets.chomp
  print 'Enter genre name: '
  genre_name = gets.chomp.capitalize
  print 'Is the album on Spotify? (true or false): '
  on_spotify = gets.chomp.downcase == 'true'
  print 'Can the album be archived? (true or false): '
  can_be_archived = gets.chomp.downcase == 'true'

  genres = load_genres

  genre = genres.find { |g| g.name == genre_name }
  unless genre
    genre = Genre.new(genres.size + 1, genre_name)
    genres << genre
    save_genres(genres)
  end

  music_album = MusicAlbum.new(music_albums.size + 1,album_name, can_be_archived, on_spotify, genre)
  items << music_album
  music_albums << music_album
  save_music_albums(music_albums)
  puts 'Music album added successfully.'
end


# adding music_album   [END]......................

# List methods  [START]...........................
def list_all_items(items)
  puts 'Listing all items:'
  items.each_with_index do |item, index|
    display_item(index + 1, item)
  end
end

def list_all_books(books)
  puts 'Listing all books:'
  books.each_with_index do |book, index|
    puts "#{index + 1}. Book -"
    display_book_details(book, book.label)
  end
end

def list_all_music_albums(music_albums)
  puts 'Listing all music albums:'
  music_albums.each_with_index do |album_data, index|
    display_music_album(index + 1, album_data['album'])
  end
end

def list_all_games(games)
  puts 'Listing all games:'
  games.each_with_index do |game, index|
    display_game(index + 1, game)
  end
end
# list genres from genre.json file

def list_genres(genres)
  puts 'Listing all genres:'
  genres.each do |genre|
    puts genre['genre_name']
  end
end

def list_authors(authors)
  puts 'Listing all authors:'
  authors.each do |author|
    puts author.name
  end
end

def list_labels(labels)
  puts 'Listing all labels:'
  labels.each do |label|
    puts label.title
    puts label.color
  end
end
# List methods  [ END]...........................

# Display methods  [ START]......................
def display_item(index, item)
  puts "#{index}. #{item.class} -"
  display_item_details(item)
end

def display_book(index, book)
  puts "#{index}. Book -"
  display_book_details(book, book.label)
end

def display_item_details(item)
  case item
  when MusicAlbum
    display_music_album_details(item)
  when Book
    display_book_details(item, item.label)
  when Game
    display_game_details(item)
  else
    puts 'No additional information available.'
  end
end

def display_music_album(index, album)
  puts "#{index}. Music Album -"
  display_music_album_details(album)
end

def display_music_album_details(album)
  puts "Album Name: #{album['album_name'] || 'No Album Name'}"
  puts "Can Be Archived: #{album['can_be_archived'] ? 'Yes' : 'No'}"
  puts "On Spotify: #{album['on_spotify'] ? 'Yes' : 'No'}"
  puts "Genre: #{album['genre']['name'] || 'No Genre'}"
end

def display_book_details(book, label)
  puts "Author: #{book.author.name || 'No Author'}"
  puts "Publisher: #{book.publisher || 'No Publisher'}"
  puts "Cover State: #{book.cover_state ? 'Good' : 'Bad'}"
  puts "Publish Date: #{book.publish_date || 'No Publish Date'}"
  if label
    puts "Label: #{label.title}"
    puts "Color: #{label.color}"
  else
    puts 'Label: No Label'
  end
end

def display_game(index, game)
  puts "#{index}. Game -"
  display_game_details(game)
end

def display_game_details(game)
  puts "Title: #{game.title}"
  puts "Description: #{game.description}"
  puts "Last Played: #{game.last_played_at}"
end

# Display methods  [ END]......................
# load and save data to json file [START]......
def load_music_albums(genres)
  if File.exist?('music_album.json')
    json_data = File.read('music_album.json')
    return [] if json_data.strip.empty?

    JSON.parse(json_data).map do |album_data|
      album = album_data['album']
      id = album_data['id']
      album_name = album['album_name']
      can_be_archived = album['can_be_archived']
      on_spotify = album['on_spotify']
      genre_name = album['genre']['name']
      genre = genres.find { |g| g.name == genre_name }
      unless genre
        genre = Genre.new(genres.size + 1, genre_name)
        genres << genre
      end

      MusicAlbum.new(id, album_name, can_be_archived, on_spotify, genre)
    end
  else
    []
  end
rescue JSON::ParserError => e
  puts "Error parsing 'music_album.json': #{e.message}"
  []
end

# save music albums
def save_music_albums(music_albums)
  data_to_save = music_albums.map do |music_album|
    {
      'id' => music_album.id,
      'album' => {
        'album_name' => music_album.album_name || 'No Album Name',
        'can_be_archived' => music_album.can_be_archived?,
        'on_spotify' => music_album.on_spotify,
        'genre' => {
          'name' => music_album.genre.name || 'No Genre'
        }
      }
    }
  end

  File.write('music_album.json', JSON.pretty_generate(data_to_save))
rescue JSON::GeneratorError => e
  puts "Error generating JSON data for 'music_album.json': #{e.message}"
end

# save genres

def save_genres(genres)
  genre_data = genres.map do |genre|
    {
      'id' => genre.id,
      'genre_name' => genre.name || 'No Genre'
    }
  end

  File.write('genre.json', JSON.pretty_generate(genre_data))
rescue JSON::GeneratorError => e
  puts "Error generating JSON data for 'genre.json': #{e.message}"
end

def load_genres
  if File.exist?('genre.json')
    json_data = File.read('genre.json')
    return [] if json_data.strip.empty?

    JSON.parse(json_data).map do |genre_data|
      id = genre_data['id']
      name = genre_data['genre_name']
      Genre.new(id, name)
    end
  else
    []
  end
rescue JSON::ParserError => e
  puts "Error parsing 'genre.json': #{e.message}"
  []
end
# load and save data to json file [END]......


# OPTIONS Loop:
genres = genres_reader.read
music_albums = music_albums_reader.read
puts 'No genres found in genre.json. You can add genres using the app.' if genres.empty?
puts 'No music albums found in music_album.json. You can add music albums using the app.' if music_albums.empty?

loop do
  app.display_options
  print 'Select an option: '
  choice = gets.chomp.to_i

  case choice
  when 1
    add_book(books, items, authors, labels)
  when 2
    add_game(games, items)
  when 3
    add_music_album(music_albums, items, genres)
  when 4
    list_all_items(items)
  when 5
    list_all_music_albums(music_albums)
  when 6
    list_all_books(books)
  when 7
    list_all_games(games)
  when 8
    list_genres(genres)
  when 9
    list_authors(authors)
  when 10
    list_labels(labels)
  when 11
    puts 'Exiting the app. Goodbye!'
    save_genres(genres)
    save_music_albums(music_albums)
    break
  else
    puts 'Invalid choice. Please select a valid option.'
  end
end
# Load genres and albums from JSON files
genres = load_genres
music_albums = load_music_albums(genres)