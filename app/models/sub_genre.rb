# frozen_string_literal: true

class SubGenre < ApplicationRecord
  belongs_to :genre, optional: true

  validates :name, uniqueness: { scope: [:genre] }

  def self.genres_from_sub_genres(artists)
    sub_genres = artists.each_with_object([]) do |artist, genres|
      artist['genres'].each { |genre| genres << genre }
    end

    Genre.includes(:sub_genres).references(:sub_genres).where(sub_genres: { name: sub_genres })
  end

  def self.create_and_match(sub_genre)
    modified_sub_genre = sub_genre
                         .gsub('hip hop', 'hip-hop')
                         .gsub(/\brap\b/, 'hip-hop')

    has_genre = false

    Genre.find_each do |genre|
      next unless modified_sub_genre.match?(genre.name)

      has_genre = true
      create(name: sub_genre, genre: genre)
    end

    create(name: sub_genre) unless has_genre
  end
end
