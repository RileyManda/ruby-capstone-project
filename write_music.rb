require 'json'

class WriteMusic
  def self.save_genres(genres)
    genre_data = genres.map do |genre|
      {
        'id' => genre.id,
        'genre_name' => genre.name || 'No Genre'
      }
    end

    json_file_path = 'genre.json'
    unless File.exist?('genre.json')
      File.open('genre.json', 'w') do |file|
        file.puts '[]'
      end
    end
    File.write(json_file_path, JSON.pretty_generate(genre_data))
    puts 'Music albums saved successfully.'
  end

  def self.save_music_albums(music_albums)
    data_to_save = music_albums.map do |album_data|
      {
        'id' => album_data['id'],
        'album' => {
          'can_be_archived' => album_data['album']['can_be_archived'],
          'on_spotify' => album_data['album']['on_spotify'],
          'album_name' => album_data['album']['album_name'],
          'genre_name' => album_data['album']['genre_name']
        }
      }
    end

    json_file_path = 'music.json'

    File.write(json_file_path, JSON.pretty_generate(data_to_save))

    puts 'Music albums saved successfully.'
  rescue JSON::GeneratorError => e
    puts "Error generating JSON data for 'music.json': #{e.message}"
  rescue StandardError => e
    puts "Error saving music albums: #{e.message}"
  end
end

# add music album create music album
def add_music_album(music_albums, items, _genres)
  puts 'Adding a new music album...'

  album_name = prompt_for_album_name
  genre_name = prompt_for_genre_name
  on_spotify = prompt_for_spotify_status
  can_be_archived = prompt_for_archiving_status

  loaded_genres = LoadMusic.load_genres
  genre = find_or_create_genre(loaded_genres, genre_name)
  save_genres(loaded_genres)
  new_id = music_albums.size + 1
  music_album = create_music_album(new_id, album_name, on_spotify, can_be_archived, genre)

  add_to_items(items, music_album)
  add_to_music_albums(music_albums, new_id, album_name, genre_name, on_spotify, can_be_archived)

  puts 'Music album added successfully.'
end

def prompt_for_album_name
  print 'Enter album name: '
  gets.chomp.to_s
end

def prompt_for_genre_name
  print 'Enter genre name: '
  gets.chomp.to_s
end

def prompt_for_spotify_status
  print 'Is the album on Spotify? (true or false): '
  input = gets.chomp.downcase
  result = input == 'true'
  puts "Debug: Input: #{input}, Result: #{result}"
  result
end

def prompt_for_archiving_status
  print 'Can the album be archived? (true or false): '
  input = gets.chomp.downcase
  result = input == 'true'
  puts "Debug: Input: #{input}, Result: #{result}"
  result
end

def find_or_create_genre(genres, genre_name)
  genre = genres.find { |g| g.name == genre_name }
  unless genre
    genre = Genre.new(genres.size + 1, genre_name)
    genres << genre
    save_genres(genres)
  end
  genre
end

def create_music_album(id, album_name, on_spotify, can_be_archived, genre)
  music_album = MusicAlbum.new(id, album_name, on_spotify, can_be_archived, genre)
  music_album.can_be_archived = can_be_archived
  music_album
end

def add_to_items(items, music_album)
  items << music_album
  save_items(items)
end

def add_to_music_albums(music_albums, new_id, album_name, genre_name, on_spotify, can_be_archived)
  music_albums << {
    'id' => new_id,
    'album' => {
      'can_be_archived' => can_be_archived,
      'on_spotify' => on_spotify,
      'album_name' => album_name,
      'genre_name' => genre_name
    }
  }
  save_music_albums(music_albums)
end

# save music album to items collection
def self.save_items(items)
  json_file_path = 'items.json'
  items_data = []

  if File.exist?(json_file_path)
    existing_items_data = JSON.parse(File.read(json_file_path))
    items_data.concat(existing_items_data)
  end

  items_data += items.map do |item|
    {
      'id' => item.id,
      'album_name' => item.album_name,
      'genre' => item.genre.name
    }
  end

  File.write(json_file_path, JSON.pretty_generate(items_data))
end
