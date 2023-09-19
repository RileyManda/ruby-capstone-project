class Genre
  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def add_item(item)
    @items ||= []
    @items << item
    item.genre = self
  end
end
