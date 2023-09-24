class Label
  attr_accessor :title, :color, :items

  def initialize(title, color)
    @id = generate_random_id
    @title = title
    @color = color
    @items = []
  end

  def generate_random_id
    SecureRandom.uuid
  end

  def add_item(item)
    @items.push(item)
  end
end
