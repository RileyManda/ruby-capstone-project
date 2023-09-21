# list methods
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

# display methods
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

# add music album
# rubocop:disable Metrics/MethodLength
def add_music_album(music_albums, items, genres)
  puts 'Adding a new music album...'
  print 'Enter album name: '
  album_name = gets.chomp.to_s
  print 'Enter genre name: '
  genre_name = gets.chomp.to_s
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

  new_id = music_albums.size + 1
  music_album = MusicAlbum.new(new_id, album_name, on_spotify, can_be_archived, genre)

  music_album.can_be_archived = can_be_archived
  items << music_album
  music_albums << { 'id' => new_id,
                    'album' => { 'can_be_archived' => can_be_archived, 'on_spotify' => on_spotify, 'album_name' => album_name,
                                 'genre_name' => genre_name } }

  save_music_albums(music_albums)
  # rubocop:enable Metrics/MethodLength
  puts 'Music album added successfully.'
end
# save music
# Save music albums to the JSON file

def save_music_albums(music_albums)
  data_to_save = music_albums.map do |album_data|
    {
      'id' => album_data['id'],
      'album' => {
        'can_be_archived' => album_data['album']['can_be_archived'],
        'on_spotify' => album_data['album']['on_spotify'],
        'album_name' => album_data['album']['album_name'],
        # 'genre_id' => album_data['album']['genre_id']
        'genre_name' => album_data['album']['genre_name']
      }
    }
  end

  json_file_path = 'music.json'

  File.write(json_file_path, JSON.pretty_generate(data_to_save))

  puts 'Music albums saved successfully.'
rescue JSON::GeneratorError => e
  puts "Error generating JSON data for '#{json_file_path}': #{e.message}"
rescue StandardError => e
  puts "Error saving music albums: #{e.message}"
end
