class LibraryApp
  def initialize
    @books = []
    @music_albums = []
    @movies = []
    @games = []
    @genres = []
    @labels = []
    @authors = []
    @sources = []
  end

  # Implement methods to add items here (e.g., add_book, add_music_album, etc.)
  def add_book
    puts 'Adding a new book...'
    print 'Enter title: '
    title = gets.chomp
    print "Enter author's name: "
    author_name = gets.chomp
    print 'Enter publisher: '
    publisher = gets.chomp
  
    book = Book.new(title, author_name, publisher)
    items << book
  
    puts 'Book added successfully.'
  end
  def add_music_album
    puts 'Adding a new music album...'
    print 'Enter album name: '
    album_name = gets.chomp
    print 'Is the album on Spotify? (true or false): '
    on_spotify = gets.chomp.downcase == 'true'
  
    music_album = MusicAlbum.new(album_name, on_spotify)
    items << music_album
  
    puts 'Music album added successfully.'
  end
  def add_movie
    puts 'Adding a new movie...'
    print 'Enter title: '
    title = gets.chomp
    print 'Enter director: '
    director = gets.chomp
    print 'Enter release year: '
    release_year = gets.chomp.to_i
  
    movie = Movie.new(title, director, release_year)
    items << movie
  
    puts 'Movie added successfully.'
  end
  def add_game
    puts 'Adding a new game...'
    print 'Enter title: '
    title = gets.chomp
    print 'Enter description: '
    description = gets.chomp
    print 'Enter last played date (YYYY-MM-DD): '
    last_played_at = Date.parse(gets.chomp)
  
    game = Game.new(title, description, last_played_at)
    items << game
  
    puts 'Game added successfully.'
  end
        
  def list_all_books
    puts 'List of all books:'
    @books.each do |book|
      puts "Title: #{book.title} | Author: #{book.author_name} | Publisher: #{book.publisher}"
    end
  end

  def list_all_music_albums
    puts 'List of all music albums:'
    @music_albums.each do |album|
      puts "Album Name: #{album.album_name} | On Spotify: #{album.on_spotify ? 'Yes' : 'No'}"
    end
  end

  def list_all_movies
    puts 'List of all movies:'
    @movies.each do |movie|
      puts "Movie Title: #{movie.title} | Director: #{movie.director} | Release Year: #{movie.release_year}"
    end
  end

  def list_all_games
    puts 'List of all games:'
    @games.each do |game|
      puts "Game Title: #{game.title} | Description: #{game.description} | Last Played: #{game.last_played_at}"
    end
  end

  def list_all_genres
    puts 'List of all genres:'
    @genres.each do |genre|
      puts genre
    end
  end

  def list_all_labels
    puts 'List of all labels:'
    @labels.each do |label|
      puts label
    end
  end

  def list_all_authors
    puts 'List of all authors:'
    @authors.each do |author|
      puts author
    end
  end

  def list_all_sources
    puts 'List of all sources:'
    @sources.each do |source|
      puts source
    end
  end
end
