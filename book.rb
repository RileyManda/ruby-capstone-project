require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state, :id

  def initialize(id, author, publisher, cover_state, publish_date, label)
    super()
    @id = Random.rand(1..100)
    @author = author
    @publisher = publisher
    @cover_state = cover_state
    @publish_date = publish_date
    @label = label
  end

  def can_be_archived?
    if @cover_state || super == 'bad'
      false
    else
      true
    end
  end
end
