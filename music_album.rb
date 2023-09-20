class MusicAlbum
  attr_accessor :can_be_archived, :on_spotify, :album_name, :genre

  def initialize(album_name, can_be_archived, on_spotify, genre)
    @album_name = album_name
    @can_be_archived = can_be_archived
    @on_spotify = on_spotify
    @genre = genre
  end

  def can_be_archived?
    @can_be_archived
  end
end
