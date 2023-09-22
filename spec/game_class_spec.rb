require 'rspec'
require_relative '../game_class'
require_relative '../item'
require 'date'
describe Game do
  let(:options) do
    {
      id: 1,
      genre: 'Adventure',
      author: 'John Doe',
      source: 'Steam',
      label: 'Bestseller',
      publish_date: Date.today - (5 * 365),
      archived: false,
      can_be_archived: true,
      genre_id: 123,
      title: 'Sample Game',
      description: 'A test game',
      last_played_at: Time.now - (2 * 365 * 24 * 60 * 60) - 1 # 2 years and 1 second ago
    }
  end
  subject { described_class.new(options) }
  describe '#can_be_archived?' do
    context 'when parent cannot be archived' do
      it 'returns false if the game has been played recently' do
        options[:last_played_at] = Time.now # Game played just now
        expect(subject.can_be_archived?).to eq(false)
      end
      it 'returns false if the parent cannot be archived' do
        options[:can_be_archived] = false
        expect(subject.can_be_archived?).to eq(false)
      end
      it "returns false if the game's publish date is within the last 10 years" do
        options[:publish_date] = Date.today - (5 * 365) # Published 5 years ago
        expect(subject.can_be_archived?).to eq(false)
      end
    end
  end
end
