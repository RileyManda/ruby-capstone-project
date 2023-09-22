require 'json'
require_relative 'game_class'
require_relative 'author'
require_relative 'item'

module SaveData
  def save_authors
    return unless File.exist?('./storage_files/authors.json')
    return unless @authors.any?

    authors_data = JSON.generate(@authors, { max_nesting: false })
    File.write('./storage_files/authors.json', authors_data)
  end

  def save_games
    return unless File.exist?('games.json')
    return unless @games.any?

    games_data = JSON.generate(@games, { max_nesting: false })
    File.write('games.json', games_data)
  end

  def save_items
    return unless File.exist?('./storage_files/items.json')
    return unless @items.any?

    items_data = JSON.generate(@items, { max_nesting: false })
    File.write('./storage_files/items.json', items_data)
  end

  def save()
    save_authors
    save_games
    save_items
  end
end

module LoadData
  def load_authors
    authors = []
    if File.exist?('./storage_files/authors.json')
      data = File.read('./storage_files/authors.json')
      if data != ''
        JSON.parse(data).map do |author|
          authors.push(Author.new(author['name']))
        end
      end
    end
    authors
  end

  def load_games
    games = []
    if File.exist?('./storage_files/games.json')
      data = File.read('./storage_files/games.json')
      if data != ''
        JSON.parse(data).map do |game|
          games.push(Game.new(game['title'], game['description'], Date.parse(game['last_played_at'])))
        end
      end
    end
    games
  end

  def load_items
    items = []
    if File.exist?('./storage_files/items.json')
      data = File.read('./storage_files/items.json')
      if data != ''
        JSON.parse(data).map do |item|
          items.push(Item.new(item['title'], item['description']))
        end
      end
    end
    items
  end

  def get_author(id)
    @authors.find { |author| author.id == id }
  end

  def get_game(id)
    @games.find { |game| game.id == id }
  end
end