class MusicAlbum
  attr_accessor :id, :can_be_archived, :on_spotify, :album_name

  def initialize(album_name, can_be_archived, on_spotify)
    @id = generate_random_id
    @can_be_archived = can_be_archived
    @on_spotify = on_spotify
    @album_name = album_name
  end

  def can_be_archived?
    @can_be_archived
  end

  def generate_random_id
    Random.rand(1..1000)
  end
end
