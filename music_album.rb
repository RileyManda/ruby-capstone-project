class MusicAlbum < Item
  attr_accessor :can_be_archived, :on_spotify, :album_name, :genre
  attr_reader :id

  def initialize(_id, album_name, on_spotify, can_be_archived, genre)
    super()
    @id = generate_random_id
    @can_be_archived = can_be_archived
    @on_spotify = on_spotify
    @album_name = album_name
    @genre = genre
  end

  def can_be_archived?
    @can_be_archived
  end

  def generate_random_id
    Random.rand(1..1000)
  end
end
