require 'date'
require_relative 'item'
require_relative 'author'
require_relative 'book'
require_relative 'game_class'
require_relative 'genre'
require_relative 'label'
require_relative 'music_album'

def display_options
  puts 'Options:'
  puts '1. Add a new book'
  puts '2. Add a new game'
  puts '3. Add a new music album'
  puts '4. List all items'
  puts '5. Quit'
end

#  store your item
items = []

loop do
  # options
  display_options

  # choose an option
  print 'Select an option: '
  choice = gets.chomp.to_i

  case choice
  when 1
    # Add a new book
    puts 'Adding a new book...'
    print "Enter author's name: "
    author_name = gets.chomp
    print 'Enter publisher: '
    publisher = gets.chomp
    print 'Enter cover state (true or false): '
    cover_state = gets.chomp.downcase == 'true'
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    author = Author.new(author_name)
    book = Book.new(author, publisher, cover_state, publish_date)
    items << book

    puts 'Book added successfully.'

  when 2
    #  Add a new game
    puts 'Adding a new game...'
    print 'Enter title: '
    title = gets.chomp
    print 'Enter description: '
    description = gets.chomp
    print 'Enter last played date (YYYY-MM-DD): '
    last_played_at = Date.parse(gets.chomp)
    game = Game.new(title, description, last_played_at)
    items << game
    puts 'Game added successfully.'

  when 3
    # Add a new music album
    puts 'Adding a new music album...'
    print 'Enter album name: '
    album_name = gets.chomp
    print 'Is the album on Spotify? (true or false): '
    on_spotify = gets.chomp.downcase == 'true'
    print 'Can the album be archived? (true or false): '
    can_be_archived = gets.chomp.downcase == 'true'

    music_album = MusicAlbum.new(album_name, can_be_archived, on_spotify)
    items << music_album

    puts 'Music album added successfully.'
  when 4
    # List all items
    puts 'Listing all items:'
    items.each_with_index do |item, index|
      if item.is_a?(MusicAlbum)
        puts "#{index + 1}. Music Album - #{item.album_name || 'No Album Name'}"
      elsif item.is_a?(Book)
        puts "#{index + 1}. Book - #{item.title || 'No Title'}"
      elsif item.is_a?(Game)
        puts "#{index + 1}. Game - #{item.title || 'No Title'}"
      else
        puts "#{index + 1}. #{item.class} - No Title"
      end
    end

  when 5
    # Exit/quit the app
    puts 'Exiting the app. Goodbye!'
    break

  else
    puts 'Invalid choice. Please select a valid option.'
  end
end
