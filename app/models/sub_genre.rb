# frozen_string_literal: true

class SubGenre < ApplicationRecord
  belongs_to :genre
  validates :name, uniqueness: { scope: [:genre] }

  def self.fetch_spotify_genres(artists)
    sub_genres = artists.each_with_object([]) do |artist, genres|
      artist['genres'].each { |genre| genres << genre }
    end

    Genre.includes(:sub_genres).references(:sub_genres).where(sub_genres: { name: sub_genres })
  end

  def self.create_and_match(sub_genre)
    Genre.find_each do |genre|
      next unless sub_genre.match?(genre.name)

      create(name: sub_genre, genre: genre)
    end

    create(name: sub_genre) unless find_by(name: sub_genre)
  end
end
