# frozen_string_literal: true

class UserArtist < ApplicationRecord
  attr_reader :photos
  belongs_to :user
  has_many :user_artist_genres, dependent: :destroy

  def seed(user)
    artists = [
      {
        name: 'Alanis Morissette',
        image_url: 'https://i.scdn.co/image/b62e0f5c189174ae5f53124e188ba0e1fd4af433'
      },
      {
        name: 'Queen',
        image_url: 'https://i.scdn.co/image/b040846ceba13c3e9c125d68389491094e7f2982'
      },
      {
        name: 'Coldplay',
        image_url: 'https://i.scdn.co/image/c942640d486338e4ae144a497f0cfd3f35ceb7af'
      },
      {
        name: 'Eels',
        image_url: 'https://i.scdn.co/image/93d37ffcc37a168fd333c1ba7119596956377a1e'
      },
      {
        name: 'Jeff Buckley',
        image_url: 'https://i.scdn.co/image/67779606c7f151618a28f62b1d24fb514d39dacf'
      }
    ]

    artists.each do |artist|
      user_artist = self.new(name: artist[:name], image_url: artist[:image_url])
      user_artist.user = user
      user_artist.save
    end
  end

  def destroy_and_create_genres(artist)
    UserArtistGenre.where(user_artist: self).destroy_all

    artist['genres'].each do |genre_name|
      user_artist_genre = UserArtistGenre.new(name: genre_name)
      user_artist_genre.user_artist = self
      user_artist_genre.save
    end
  end
end
