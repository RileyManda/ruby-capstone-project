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

    File.write(json_file_path, JSON.pretty_generate(genre_data))

    puts 'Genres saved successfully.'
  rescue JSON::GeneratorError => e
    puts "Error generating JSON data for 'genre.json': #{e.message}"
  rescue StandardError => e
    puts "Error saving genres: #{e.message}"
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
  loaded_genres = LoadMusic.load_genres
  genre = loaded_genres.find { |g| g.name == genre_name }
  unless genre
    genre = Genre.new(genres.size + 1, genre_name)
    loaded_genres << genre
    save_genres(loaded_genres)
  end

  new_id = music_albums.size + 1
  music_album = MusicAlbum.new(new_id, album_name, on_spotify, can_be_archived, genre)

  music_album.can_be_archived = can_be_archived
  items << music_album

  puts 'Items array content after adding music album:'
  puts items.inspect

  save_items(items)

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
  puts 'Music album added successfully.'
end


# save music album to items collection
def self.save_items(items)
  items_data = items.map do |item|
    {
      'id' => item.id,
      'album_name' => item.album_name,
      'genre' => item.genre.name
    }
  end

  json_file_path = 'items.json'

  File.write(json_file_path, JSON.pretty_generate(items_data))

  puts 'Items saved successfully.'
rescue JSON::GeneratorError => e
  puts "Error generating JSON data for 'items.json': #{e.message}"
rescue StandardError => e
  puts "Error saving items: #{e.message}"
end

