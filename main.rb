require_relative 'preserve_data'
require 'securerandom'
require 'json'
require 'date'
require_relative 'music_helper'
require_relative 'book_helper'
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
music_albums_reader = ReadFile.new('music.json')
music_albums = music_albums_reader.read

labels_reader = ReadFile.new('label.json')
books_reader = ReadFile.new('book.json')
books = books_reader.read
# adding game   [START]......................................................................
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

# adding game   [END]........................................................................................


# save and load book [Start]

def save_labels(labels)
  label_data = labels.map do |label|
    {
      'title' => label.title || 'No Label',
      'color' => label.color || 'No Label'
    }
  end

  File.write('label.json', JSON.pretty_generate(label_data))

  puts 'Labels saved successfully.'
end

def load_books(labels)
  return [] unless File.exist?('book.json')

  json_data = File.read('book.json')
  books_data = JSON.parse(json_data)

  books_data.map do |book_data|
    load_books_details(book_data, labels)
  end
rescue JSON::ParserError => e
  puts "Error parsing 'book.json': #{e.message}"
  []
end

def load_books_details(book_data, _labels)
  author = book_data['author']
  publisher = book_data['publisher']
  cover_state = book_data['cover_state']
  publish_date = book_data['publish_date']
  label = extract_label(book_data['label'])
  id = SecureRandom.uuid
  puts "Books: Author=#{author},
   Publisher=#{publisher}, Cover state=#{cover_state}, Date=#{publish_date}, Label=#{label}"

  Book.new(id, author, publisher, cover_state, publish_date, label)
end

def extract_label(label_data)
  label_data.is_a?(Hash) && label_data.key?('title') ? label_data['color'] : nil
end

def find_or_create_label(labels, title, color)
  label = labels.find { |l| l.title == title && l.color == label_color }
  unless label
    label = Label.new(title, color)
    labels << label
  end
  label
end

def load_labels
  if File.exist?('label.json')
    json_data = File.read('label.json')
    return [] if json_data.strip.empty?

    JSON.parse(json_data).map do |label_data|
      title = label_data['title']
      color = label_data['color']
      Label.new(title, color)
    end
  else
    []
  end
rescue JSON::ParserError => e
  puts "Error parsing 'label.json': #{e.message}"
  []
end
labels_reader.read
books = books_reader.read
puts 'No labels found in label.json. You can add labels using the app.' if labels.empty?
puts 'No books found in book.json. You can add books using the app.' if books.empty?
# load and save book [End]

# load and save data to json file [END]......


# load music genres   [START]>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

genres = genres_reader.read
music_albums = music_albums_reader.read
puts 'No genres found in genre.json. You can add genres using the app.' if genres.empty?
puts 'No music albums found in music.json. You can add music albums using the app.' if music_albums.empty?
# music_album   [END]>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# List methods  [START]...........................
def list_all_items(items)
  puts 'Listing all items:'
  items.each_with_index do |item, index|
    display_item(index + 1, item)
  end
end

def list_all_games(games)
  puts 'Listing all games:'
  games.each_with_index do |game, index|
    display_game(index + 1, game)
  end
end

def list_authors(authors)
  puts 'Listing all authors:'
  authors.each do |author|
    puts author.name
  end
end

# List methods  [ END]...........................

# Display methods  [ START]......................
def display_item(index, item)
  puts "#{index}. #{item.class} -"
  display_item_details(item)
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

def display_game(index, game)
  puts "#{index}. Game -"
  display_game_details(game)
end

def display_game_details(game)
  puts "Title: #{game.title}"
  puts "Description: #{game.description}"
  puts "Last Played: #{game.last_played_at}"
end

# Display methods  [ END].....................

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
    list_all_books(books, labels)
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
    break
  else
    puts 'Invalid choice. Please select a valid option.'
  end
end

# Load books and labels from JSON files
labels = load_labels
books = load_books(labels)

# Load genres and music from JSON files
genres = LoadMusic.load_genres
music_albums = LoadMusic.load_music_albums(genres)

