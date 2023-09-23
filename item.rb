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
  def genre=(genre)
    @genre = genre
    @genre.items.push(self) unless @genre.items.include?(self)
  end

  def label=(label)
    @label = label
    @label.items.push(self) unless @label.items.include?(self)
  end

  def author=(author)
    @author = author
    @author.items.push(self) unless @author.items.include?(self)
  end
  def move_to_archive
    if can_be_archived?
      @archived = true
    end
  end
end