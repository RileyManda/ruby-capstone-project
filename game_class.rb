class Game < Item
  attr_accessor :last_played_at

  def initialize(title, description, last_played_at)
    super(title, description)
    @last_played_at = last_played_at
  end

  # Implement the can_be_archived? method
  def can_be_archived?
    parent_can_be_archived = super
    return false unless parent_can_be_archived
    return false unless Time.now - @last_played_at > 2 * 365 * 24 * 60 * 60 # 2 years in seconds

    true
  end
end
