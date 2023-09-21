require 'json'

def list_labels(labels)
  puts 'Listing all labels:'
  labels.each do |label|
    puts label.title
    puts label.color
  end
end

def list_all_books(books, labels)
  puts 'Listing all books:'
  books.each_with_index do |book_data, _index|
    display_book_details(book_data, labels)
  end
end

def display_book_details(book_data, labels)
  author = book_data['author']
  publisher = book_data['publisher']
  cover_state = book_data['cover_state']
  publish_date = book_data['publish_date']
  label_title = book_data['label']
  label = labels.find { |l| l.title == label_title }
  puts "Book - Author: #{author} | Publisher: #{publisher} | Cover State: #{cover_state} | " \
       "Publish Date: #{publish_date} | Label: #{label ? label.title : 'Unknown'}"
end


def display_book(index, book)
  puts "#{index}. Book -"
  display_book_details(book, book.label)
end

# Adding book and label methods [START]........................
# rubocop:disable Metrics/MethodLength
def add_book(books, items, authors, labels)
  puts 'Adding a new book...'
  print 'Enter author\'s name: '
  author_name = gets.chomp
  print 'Enter publisher: '
  publisher = gets.chomp
  print 'Enter cover state (true or false): '
  cover_state = gets.chomp.downcase == 'true'
  print 'Enter publish date (YYYY-MM-DD): '
  publish_date = Date.parse(gets.chomp)
  author = authors.find { |a| a.name == author_name }
  author ||= Author.new(author_name)
  authors << author

  # print 'Enter label title: '
  # title = gets.chomp
  # print 'Enter label color: '
  # color = gets.chomp

  label = find_or_create_label(labels, title, color)
  id = Random.rand(1..100)
  book_data = {
    'author' => author_name,
    'publisher' => publisher,
    'cover_state' => cover_state,
    'publish_date' => publish_date.to_s,
    'label' => label.title
  }
  books << book_data
  book = Book.new(id, author_name, publisher, cover_state, publish_date, label)
  items << book
  save_books(books)
  save_labels(labels)
  puts 'Book added successfully.'
end

# rubocop:enable Metrics/MethodLength
def find_or_create_author(authors)
  puts "Enter author's name: "
  author_name = gets.chomp
  author = authors.find { |a| a.name == author_name }
  author ||= Author.new(author_name)
  authors << author
  author
end

def input_publisher
  print 'Enter publisher: '
  gets.chomp
end

def input_cover_state
  print 'Enter cover state (true or false): '
  gets.chomp.downcase == 'true'
end

def input_publish_date
  print 'Enter publish date (YYYY-MM-DD): '
  Date.parse(gets.chomp)
end

def find_or_create_label(labels, title, color)
  label = labels.find { |l| l.title == title && l.color == color }
  unless label
    label = Label.new(title, color)
    labels << label
  end
  label
end

def save_books(books)
  data_to_save = books.map do |book_data|
    {
      'author' => book_data['author'],
      'publisher' => book_data['publisher'],
      'cover_state' => book_data['cover_state'],
      'publish_date' => book_data['publish_date'],
      'label' => book_data['label']
    }
  end
  json_file_path = 'book.json'
  File.write(json_file_path, JSON.pretty_generate(data_to_save))
  puts 'Books saved successfully.'
  books.replace(data_to_save)
rescue JSON::GeneratorError => e
  puts "Error generating JSON data for '#{json_file_path}': #{e.message}"
rescue StandardError => e
  puts "Error saving books: #{e.message}"
end
# Adding book and label methods [END]........................
