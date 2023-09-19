class Book
  attr_accessor :publisher, :cover_state

  def initialize(author, publisher, cover_state, publish_date)
    @author = author
    @publisher = publisher
    @cover_state = cover_state
    @public_date = publish_date
  end

  def can_be_archived?
    if @cover_state || super == 'bad'
      true
    else
      false
    end
  end
end
