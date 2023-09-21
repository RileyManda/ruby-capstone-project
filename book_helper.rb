def list_labels(labels)
    puts 'Listing all labels:'
    labels.each do |label|
        puts label.title
        puts label.color
    end
end

def list_all_books(books, labels)
    puts 'Listing all books:'
    books.each_with_index do |book_data, index|
      display_book_details(book_data, labels)
    end
  end
  
  def display_book_details(book_data, labels)
    author = book_data['author']
    publisher = book_data['publisher']
    cover_state = book_data['cover_state']
    publish_date = book_data['publish_date']
    label = labels.find { |l| l.title == book_data['label'] }
    
    # author = 'No Author' if author? || author
    # publisher = 'No Publisher' if publisher.nil? || publisher
    # cover_state = 'Unknown' if cover_state.nil?
    # publish_date = 'Unknown' if publish_date.nil?


    
    puts "Book - Author: #{author} | Publisher: #{publisher} | Cover State: #{cover_state} | Publish Date: #{publish_date} | Label: #{label ? label.title : 'Unknown'}"
  end
  

def display_book(index, book)
    puts "#{index}. Book -"
    display_book_details(book, book.label)
end

# adding book and label methods [START].................................................
def add_book(books, items, authors, labels)
    puts 'Adding a new book...'
    print "Enter author's name: "
    author_name = gets.chomp
    print 'Enter publisher: '
    publisher = gets.chomp
    print 'Enter cover state (true or false): '
    cover_state = gets.chomp.downcase == 'true'
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
  
    author = authors.find { |a| a.name == author_name }
    
    label = labels.find { |l| l.title == label_title}
    title = 'Default'
    color = 'Default'
    label = Label.new(title, color)  # Create a default label if not found.
  
    # generate a if statement if author is nil class
    
    
  
    book = Book.new(author, publisher, cover_state, publish_date, label)
  
    items << book
    books << {
      'author' => book.author,
      'publisher' => book.publisher,
      'cover_state' => book.cover_state,
      'publish_date' => book.publish_date.to_s,
      'label' => book.label.title
    }
  
    save_books(books)
  
    puts 'Book added successfully.'
  end
  
  
  
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
  
def find_or_create_label(labels)
    print 'Enter label: '
    title = gets.chomp
    title = 'Default' if title.empty?
    print 'Enter color: '
    color = gets.chomp
    color = 'Default' if color.empty?
    label = labels.find { |b| b.title == title && b.color == color }
    label = Label.new(title, color)
    label
end
def save_books(books)
    data_to_save = books.map do |book_data|
      {
      'author' => book_data.author,
      'publisher' => book_data.publisher,
      'cover_state' => book_data.cover_state,
      'publish_date' => book_data.publish_date,
      'label' => book_data.label
        
      }
    end
    json_file_path = 'book.json'

    File.write(json_file_path, JSON.pretty_generate(data_to_save))
  
    puts 'Books saved successfully.'
rescue JSON::GeneratorError => e
    puts "Error generating JSON data for '#{json_file_path}': #{e.message}"
rescue StandardError => e
    puts "Error saving books: #{e.message}"
end

  # adding book and label methods [END]........................................................