require_relative '../game_class'
require 'rspec'

RSpec.describe Game do
  it 'should create a new game' do
    game = Game.new(id: '123', genre: 'Action', title: 'Game Title', description: 'Game Description',
                    last_played_at: Time.now)
    expect(game).to be_a(Game)
  end
end
