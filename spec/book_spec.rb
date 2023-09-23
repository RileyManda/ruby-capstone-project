require_relative '../book'
require 'rspec'
require 'date'

RSpec.describe Book do
  let(:sample_book) do
    Book.new(
      '123',
      'John Doe',
      'Publisher XYZ',
      'good',
      Date.today,
      'Best Sellers'
    )
  end

  # Test the initialization of a Book object
  it 'should create a new book' do
    expect(sample_book).to be_a(Book)
  end

  # Test the generate_random_id method
  it 'should generate a random ID' do
    expect(sample_book.id).to be_a(String)
  end

  # Test the author attribute
  it 'should have an author' do
    expect(sample_book.author).to eq('John Doe')
  end

  # Test the publisher attribute
  it 'should have a publisher' do
    expect(sample_book.publisher).to eq('Publisher XYZ')
  end

  # Test the publish_date attribute
  it 'should have a publish_date' do
    expect(sample_book.publish_date).to eq(Date.today)
  end

  # Test the label attribute
  it 'should have a label' do
    expect(sample_book.label).to eq('Best Sellers')
  end
end
