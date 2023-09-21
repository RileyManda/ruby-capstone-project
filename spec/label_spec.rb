require_relative '../label'
require 'securerandom'

RSpec.describe Label do
  describe '#initialize' do
    it 'creates a Label instance with attributes' do
      title = 'Label Title'
      color = 'Label Color'

      label = Label.new(title, color)

      expect(label.title).to eq(title)
      expect(label.color).to eq(color)
      expect(label.items).to be_empty
    end
  end

  describe '#generate_random_id' do
    it 'generates a random ID' do
      label = Label.new('Label Title', 'Label Color')
      expect(label.generate_random_id).not_to be_nil
    end
  end

  describe '#add_item' do
    it 'adds an item to the label' do
      label = Label.new('Label Title', 'Label Color')
      item = double('Item')

      label.add_item(item)

      expect(label.items).to include(item)
    end
  end
end
