# rubocop:disable Metrics/BlockLength
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
  display_options
  print 'Select an option: '
  choice = gets.chomp.to_i

  case choice
  when 1
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
    puts 'Adding a new game...'
    print 'Enter title: '
    title = gets.chomp
    print 'Enter description: '
    description = gets.chomp
    print 'Enter last played date (YYYY-MM-DD): '
    last_played_at = Date.parse(gets.chomp)
    game = Game.new(title: title, description: description, last_played_at: last_played_at)

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
    list_all_items(items)

  when 5
    puts 'Exiting the app. Goodbye!'
    break

  else
    puts 'Invalid choice. Please select a valid option.'
  end

  def list_all_items(items)
    puts 'Listing all items:'
    items.each_with_index do |item, index|
      display_item(index + 1, item)
    end
  end

  def display_item(index, item)
    case item
    when MusicAlbum
      puts "#{index}. Music Album - #{item.album_name || 'No Album Name'}"
    when Book
      puts "#{index}. Book - #{book_info(item)}"
    when Game
      puts "#{index}. Game: - #{item.title} | Description: -#{item.description} | Last Played: - #{item.last_played_at}"
    else
      puts "#{index}. #{item.class} - No Title"
    end
  end

  def book_info(book)
    "Publisher: #{book.publisher || 'No Publisher'} - Cover State: #{book.cover_state ? 'Good' : 'Bad'}"
  end
end
# rubocop:enable Metrics/BlockLength
