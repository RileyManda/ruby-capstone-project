require 'rspec'
require_relative '../music_album'
require_relative '../write_music'
require_relative '../load_music'
require_relative '../genre'
require_relative '../music_helper'

RSpec.describe MusicAlbum do
  let(:genre1) { Genre.new(1, 'genre1') }
  let(:genre2) { Genre.new(2, 'genre2') }
  let(:genre3) { Genre.new(3, 'genre3') }
  let(:genre4) { Genre.new(4, 'genre4') }

  it 'expects each item to have an id' do
    music_album1 = MusicAlbum.new(nil, 'Sample Album 1', true, false, genre1)
    music_album2 = MusicAlbum.new(nil, 'Sample Album 2', true, false, genre2)
    music_album3 = MusicAlbum.new(nil, 'Sample Album 3', true, false, genre3)

    expect(music_album1.id).not_to eq(music_album2.id)
    expect(music_album1.id).not_to eq(music_album3.id)
    expect(music_album2.id).not_to eq(music_album3.id)
  end

  it 'expects the album_name to be set correctly' do
    music_album = MusicAlbum.new(nil, 'Sample Album', true, false, genre1)
    expect(music_album.album_name).to eq('Sample Album')
  end
  it 'expects the can_be_archived attribute to be set correctly' do
    music_album = MusicAlbum.new(nil, 'Sample Album', true, false, genre1)
    expect(music_album.can_be_archived).to be false
  end
  it 'expects the genre attribute to be set correctly' do
    music_album = MusicAlbum.new(nil, 'Sample Album', true, false, genre1)
    expect(music_album.genre).to eq(genre1)
  end

  it 'expects can_be_archived? to return the correct value' do
    music_album1 = MusicAlbum.new(nil, 'Sample Album 1', true, false, genre1)
    music_album2 = MusicAlbum.new(nil, 'Sample Album 2', false, true, genre2)

    expect(music_album1.can_be_archived?).to be false
    expect(music_album2.can_be_archived?).to be true
  end
  it 'saves music albums to the JSON file' do
    music_albums = [
      {
        'id' => 1,
        'album' => {
          'can_be_archived' => false,
          'on_spotify' => false,
          'album_name' => 'test1',
          'genre_name' => 'genre1'
        }
      }
    ]
    expect { WriteMusic.save_music_albums(music_albums) }.not_to raise_error
  end

  it 'should save genre to genre.json' do
    music_albums = [
      {
        'id' => 1,
        genre_name: 'genre1'

      }
    ]
    expect { WriteMusic.save_music_albums(music_albums) }.not_to raise_error
  end
  it 'saves genres to the JSON file' do
    genres = [genre1, genre2]
    expect { WriteMusic.save_genres(genres) }.not_to raise_error
  end

  it 'loads genres correctly from an existing "genre.json" file' do
    File.write('genre.json', '[{"id": 1, "genre_name": "Rock"}, {"id": 2, "genre_name": "Pop"}]')
    expect(LoadMusic.load_genres).to all(be_a(Genre))
    File.delete('genre.json')
  end

  it 'loads music albums correctly from an existing "music.json" file' do
    File.write('music.json',
               '[{"id": 1, "album": {"can_be_archived": false, "on_spotify": false, "album_name": "Album1", "genre_name": "Rock"}}]')
    loaded_music_albums = LoadMusic.load_music_albums([])
    expect(loaded_music_albums).to all(be_a(MusicAlbum))
    expect(loaded_music_albums.map(&:album_name)).to include('Album1')
    File.delete('music.json')
  end
  it 'loads music albums correctly from an existing "music.json" file' do
    valid_json_content = <<~JSON
      [
        {
          "id": 1,
          "album": {
            "can_be_archived": false,
            "on_spotify": false,
            "album_name": "Album1",
            "genre_name": "Rock"
          }
        }
      ]
    JSON

    File.write('music.json', valid_json_content)
    loaded_music_albums = LoadMusic.load_music_albums([])
    expect(loaded_music_albums).to all(be_a(MusicAlbum))
    expect(loaded_music_albums.map(&:album_name)).to include('Album1')
    File.delete('music.json')
  end
end
