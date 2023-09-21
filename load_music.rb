require 'json'

class LoadMusic
  # load genres
  def self.load_genres
    return [] unless File.exist?('genre.json')

    json_data = File.read('genre.json')
    genre_data = JSON.parse(json_data)

    genre_data.map do |data|
      id = data['id']
      name = data['genre_name']
      Genre.new(id, name)
    end
  rescue JSON::ParserError => e
    puts "Error parsing 'genre.json': #{e.message}"
    []
  end

  # load music albums
  def self.load_music_albums(genres)
    return [] unless File.exist?('music.json')

    json_data = File.read('music.json')
    music_albums_data = JSON.parse(json_data)

    music_albums_data.map do |album_data|
      load_music_album(album_data, genres)
    end
  rescue JSON::ParserError => e
    puts "Error parsing 'music.json': #{e.message}"
    []
  end

  # load  albums from store
  def self.load_music_album(album_data, genres)
    album = album_data['album']
    id = album_data['id']
    album_name = album['album_name']
    can_be_archived = album['can_be_archived']
    on_spotify = album['on_spotify']
    genre_name = extract_genre_name(album['genre'])

    genre = find_or_create_genre(genres, genre_name)
    puts 'Loaded music album:'
    puts "  ID=#{id}"
    puts "  Name=#{album_name}"
    puts "  Can Be Archived=#{can_be_archived}"
    puts "  On Spotify=#{on_spotify}"
    puts "  Genre=#{genre_name}"

    MusicAlbum.new(id, album_name, on_spotify, can_be_archived, genre)
  end

  # extract genres to display tio list genres
  def self.extract_genre_name(genre_data)
    genre_data.is_a?(Hash) && genre_data.key?('name') ? genre_data['name'] : nil
  end

  def self.find_or_create_genre(genres, genre_name)
    genre = genres.find { |g| g.name == genre_name }
    unless genre
      genre = Genre.new(genres.size + 1, genre_name)
      genres << genre
    end
    genre
  end
end
