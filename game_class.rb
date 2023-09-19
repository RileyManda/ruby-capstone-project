class Game
  attr_accessor :title, :description, :created_at, :last_played_at

  def initialize(title, description, last_played_at)
    @title = title
    @description = description
    @created_at = Time.now
    @last_played_at = last_played_at
  end

  def can_be_archived?
    parent_can_be_archived = super
    return false unless parent_can_be_archived
    return false unless Time.now - @last_played_at > 2 * 365 * 24 * 60 * 60

    true
  end
end
