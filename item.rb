class Book
  attr_accessor :title, :author_name, :publisher

  def initialize(title, author_name, publisher)
    @title = title
    @author_name = author_name
    @publisher = publisher
  end
end

class MusicAlbum
  attr_accessor :album_name, :on_spotify

  def initialize(album_name, on_spotify)
    @album_name = album_name
    @on_spotify = on_spotify
  end
end

class Movie
  attr_accessor :title, :director, :release_year

  def initialize(title, director, release_year)
    @title = title
    @director = director
    @release_year = release_year
  end
end

class Game
  attr_accessor :title, :description, :last_played_at

  def initialize(title, description, last_played_at)
    @title = title
    @description = description
    @last_played_at = last_played_at
  end
end
