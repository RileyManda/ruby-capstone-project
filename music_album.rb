class MusicAlbum
  attr_accessor :id, :can_be_archived, :on_spotify, :item_id

  def initialize(id, can_be_archived, on_spotify, item_id)
    @id = id
    @can_be_archived = can_be_archived
    @on_spotify = on_spotify
    @item_id = item_id
  end

  def can_be_archived?
    @can_be_archived
  end
end
