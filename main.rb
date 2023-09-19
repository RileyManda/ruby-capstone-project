# main.rb
require 'date'
require_relative 'app'

app = App.new

loop do
  app.display_options
  print 'Select an option: '
  choice = gets.chomp.to_i

  case choice
  when 1
    app.add_book
  when 2
    app.add_game
  when 3
    app.add_music_album
  when 4
    app.list_all_items
  when 5
    app.list_all_music_albums
  when 6
    app.list_all_books
  when 7
    app.list_all_games
  when 8
    puts 'Exiting the app. Goodbye!'
    break
  else
    puts 'Invalid choice. Please select a valid option.'
  end
end
