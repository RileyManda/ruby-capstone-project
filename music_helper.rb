require_relative 'write_music'
require_relative 'load_music'

# Save music albums to the JSON file
def save_music_albums(music_albums)
  WriteMusic.save_music_albums(music_albums)
end

# save genre
def save_genres(genres)
  WriteMusic.save_genres(genres)
end

# load music albums
def load_music_albums(genres)
  LoadMusic.load_music_albums(genres)
end

def find_or_create_genre(genres, genre_name)
  LoadMusic.find_or_create_genre(genres, genre_name)
end

# list methods >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
def list_genres(genres)
  puts 'Listing all genres:'
  genres.each do |genre|
    puts genre['genre_name']
  end
end

def list_all_music_albums(music_albums)
  puts 'Listing all music albums:'
  music_albums.each_with_index do |album_data, index|
    display_music_album(index + 1, album_data['album'])
  end
end

# display methods music
def display_music_album(index, album)
  puts "#{index}. Music Album -"
  display_music_album_details(album)
end

def display_music_album_details(album)
  puts "Album Name: #{album['album_name'] || 'No Album Name'}"
  puts "Can Be Archived: #{album['can_be_archived'] ? 'Yes' : 'No'}"
  puts "On Spotify: #{album['on_spotify'] ? 'Yes' : 'No'}"
  genre_name = album['genre'] ? album['genre']['name'] : nil
  puts "Genre: #{genre_name || 'No Genre'}"
end
