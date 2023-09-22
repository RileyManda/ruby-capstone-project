require 'date'
require_relative 'item'
require_relative 'author'
require_relative 'book'
require_relative 'game_class'
require_relative 'genre'
require_relative 'label'
require_relative 'music_album'

class App
  def initialize
    @books = []
    @music_albums = []
    @movies = []
    @games = []
    @genres = []
    @labels = []
    @authors = []
    @sources = []
    @labels = []

    load_games
  end

  def display_options
    puts 'Options:'
    puts '1. Add a new book'
    puts '2. Add a new game'
    puts '3. Add a new music album'
    puts '4. List all items'
    puts '5. List all music albums'
    puts '6. List all books'
    puts '7. List of games'
    puts '8. List all genres (e.g Comedy, Thriller)'
    puts '9. List all authors (e.g. Stephen King)'
    puts '10. List all labels (e.g. Gift', 'New)'
    puts '11. Quit'
  end

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
    store_game(title, description, last_played_at)
  end

  # adding game   [END]...............................
  def store_game(title, description, last_played_at)
    @games << {
      'title' => title,
      'description' => description,
      'last_played_at' => last_played_at
    }
    File.write('games.json', JSON.pretty_generate(@games))
  end

  def load_games
    games_data = JSON.parse(File.read('games.json'))
    @games = games_data
  rescue JSON::ParserError => e
    puts "Error parsing games.json: #{e.message}"
  end

  def list_all_games
    puts 'Listing all games:'
    @games.each_with_index do |game, index|
      puts "#{index + 1} '#{game['title']}'"
    end
  end
end
