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
  end

  def display_options
    puts 'Options:'
    puts '1. Add a new book'
    puts '2. Add a new game'
    puts '3. Add a new music album'
    puts '4. List all items'
    puts '5. List music_albums'
    puts '6. List all books'
    puts '7. List all games'
    puts '8. Quit'
  end
end
