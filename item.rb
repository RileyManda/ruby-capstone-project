class Item
  attr_accessor :id, :genre, :author, :source, :label, :publish_date, :archived, :can_be_archived, :genre_id

  def initialize(options = {})
    @id = options[:id]
    @genre = options[:genre]
    @author = options[:author]
    @source = options[:source]
    @label = options[:label]
    @publish_date = options[:publish_date]
    @archived = options[:archived]
    @can_be_archived = options[:can_be_archived]
    @genre_id = options[:genre_id]
  end

  def can_be_archived?
    ten_years_ago = Date.today - (10 * 365)
    @publish_date <= ten_years_ago && @can_be_archived
  end
end
