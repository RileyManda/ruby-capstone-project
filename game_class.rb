class Game < Item
  attr_accessor :title, :description, :last_played_at

  def initialize(options = {})
    super(options)
    @title = options[:title]
    @description = options[:description]
    @last_played_at = options[:last_played_at]
  end

  def can_be_archived?
    parent_can_be_archived = super
    return false unless parent_can_be_archived
    return false unless Time.now - @last_played_at > 2 * 365 * 24 * 60 * 60 # 2 years in seconds

    true
  end
end
