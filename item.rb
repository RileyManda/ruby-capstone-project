class Item
  attr_accessor :id, :genre, :author, :source, :label, :public_date, :archived, :can_be_archived, :genre_id

  def initialize(id,
                 genre, author, source,
                 label, public_date, archived, can_be_archived, genre_id)
    @id = id
    @genre = genre
    @author = author
    @source = source
    @label = label
    @public_date = public_date
    @archived = archived
    @can_be_archived = can_be_archived
    @genre_id = genre_id
  end

  def can_be_archived?
    @can_be_archived
  end
end
