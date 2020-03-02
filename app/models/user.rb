# frozen_string_literal: true

require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :omniauthable,
          omniauth_providers: %i[spotify]

  has_many :user_genres, dependent: :destroy, inverse_of: :user
  has_many :user_artists, dependent: :destroy, inverse_of: :user
  has_many :genres, through: :user_genres
  has_many :likes, dependent: :destroy, inverse_of: :user
  has_one_attached :avatar

  def add_spotify_genres
    return user_artists if user_artists.empty?

    genres = SubGenre.genres_from_sub_genres(user_artists)

    genres.each { |genre| UserGenre.create(user: self, genre: genre) }
  end

  def add_spotify_artists
    artists = SpotifyTopArtists.call(self)['items'].first(8)
    return UserArtist.seed(self) unless artists

    artists.map do |artist|
      user_artist = UserArtist.new(
        name: artist['name'],
        image_url: artist['images'].first['url']
      )

      user_artist.user = self
      user_artist.save
    end
  end

  def self.from_omniauth(auth)
    user = find_or_initialize_by(email: auth.info.email)

    user.persisted? ? update_user_from_spotify(user, auth) : create_user_from_spotify(user, auth)
    user.replace_user_picture(auth) if auth.info.image

    user
  end

  def self.create_user_from_spotify(user, auth)
    user.assign_attributes(
      email: auth.info.email,
      nickname: auth.info.nickname,
      password: Devise.friendly_token[0, 20],
      provider: auth.provider,
      uid: auth.uid,
      access_token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token
    )
  end

  def self.update_user_from_spotify(user, auth)
    user.assign_attributes(
      nickname: auth.info.nickname,
      provider: auth.provider,
      uid: auth.uid,
      access_token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token
    )
  end

  def replace_user_picture(auth)
    url = auth.info.image
    file = URI.open(url)
    # It will replace the previous avatar if there was one
    avatar.attach(io: file, filename: "#{nickname}_avatar.png", content_type: 'image/png')
  end
end
