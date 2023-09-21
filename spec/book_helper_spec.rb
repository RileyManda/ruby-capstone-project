require 'rspec'
require_relative '../book_helper'
require 'date'
require_relative '../label'
require 'securerandom'

RSpec.describe 'BookHelper' do
  let(:labels) do
    [
      Label.new('Label 1', 'Red'),
      Label.new('Label 2', 'Blue')
    ]
  end

  let(:books) do
    [
      {
        'author' => 'Author 1',
        'publisher' => 'Publisher 1',
        'cover_state' => true,
        'publish_date' => '2023-01-01',
        'label' => 'Label 1'
      },
      {
        'author' => 'Author 2',
        'publisher' => 'Publisher 2',
        'cover_state' => false,
        'publish_date' => '2023-02-01',
        'label' => 'Label 2'
      }
    ]
  end

  describe '#list_labels' do
    it 'prints all label titles and colors' do
      expect { list_labels(labels) }.to output(
        <<~OUTPUT
          Listing all labels:
          Label 1
          Red
          Label 2
          Blue
        OUTPUT
      ).to_stdout
    end
  end

  describe '#list_all_books' do
    it 'prints all book details' do
      expect { list_all_books(books, labels) }.to output(
        <<~OUTPUT
          Listing all books:
          Book - Author: Author 1 | Publisher: Publisher 1 | Cover State: true | Publish Date: 2023-01-01 | Label: Label 1
          Book - Author: Author 2 | Publisher: Publisher 2 | Cover State: false | Publish Date: 2023-02-01 | Label: Label 2
        OUTPUT
      ).to_stdout
    end
  end
end
