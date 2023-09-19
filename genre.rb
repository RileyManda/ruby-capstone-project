class Genre
  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def add_item(item)
    @items << item
  end
end
