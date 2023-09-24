class Author
  attr_accessor :name, :items

  def initialize(name)
    @name = name
    @items = []
  end

  # add_item method
  def add_item(item)
    @items << item
    item.author = self
  end
end
