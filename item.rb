class Item
  attr_accessor :id, :genre, :author, :label, :publish_date, :archived, :can_be_archived, :genre_id

  def initialize(options = {})
    @id = options[:id]
    @genre = options[:genre]
    @author = options[:author]
    @label = options[:label]
    @publish_date = options[:publish_date]
    @archived = options[:archived]
    @can_be_archived = options[:can_be_archived]
    @genre_id = options[:genre_id]
  end

  def can_be_archived?
    ten_years_ago = Date.today - (10 * 365)
    @publish_date <= ten_years_ago
  end
end
