require_relative '../book'

RSpec.describe Book do
  describe '#initialize' do
    it 'creates a Book instance with attributes' do
      author = 'Author'
      publisher = 'Publisher'
      cover_state = true
      publish_date = '2023-09-18'
      label = 'Label'

      book = Book.new(nil, author, publisher, cover_state, publish_date, label)

      expect(book.id).not_to be_nil
      expect(book.author).to eq(author)
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq(cover_state)
      expect(book.publish_date).to eq(publish_date)
      expect(book.label).to eq(label)
    end
  end

  describe '#generate_random_id' do
    it 'generates a random ID' do
      book = Book.new(nil, 'Author', 'Publisher', true, '2023-09-18', 'Label')
      expect(book.generate_random_id).not_to be_nil
    end
  end

  describe '#can_be_archived?' do
    context 'when cover_state is true' do
      it 'returns false' do
        book = Book.new(nil, 'Author', 'Publisher', true, '2023-09-18', 'Label')
        expect(book.can_be_archived?).to be_falsey
      end
    end

    context 'when cover_state is false and super is not "bad"' do
      it 'returns true' do
        allow_any_instance_of(Item).to receive(:can_be_archived?).and_return(true)
        book = Book.new(nil, 'Author', 'Publisher', false, '2023-09-18', 'Label')
        expect(book.can_be_archived?).to be_truthy
      end
    end
  end
end
