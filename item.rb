class Item
  attr_accessor :title, :description, :created_at
  attr_reader :author

  def initialize(title, description)
    @title = title
    @description = description
    @created_at = Time.now
    @author = nil
  end

  # Implement setter for author
  def author=(author)
    @author = author
    author.add_item(self)
  end
end
