require_relative 'item'
require 'securerandom'

class Book < Item
  attr_accessor :author, :publisher, :cover_state, :publish_date, :label
  attr_reader :id

  def initialize(_id, author, publisher, cover_state, publish_date, label)
    super()
    @id = generate_random_id
    @author = author
    @publisher = publisher
    @cover_state = cover_state
    @publish_date = publish_date
    @label = label
  end

  def generate_random_id
    SecureRandom.uuid
  end

  def can_be_archived?
    if @cover_state || super == 'bad'
      false
    else
      true
    end
  end
end
