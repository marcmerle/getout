# frozen_string_literal: true

class SubGenre < ApplicationRecord
  belongs_to :genre, optional: true
  has_many :user_artist_genres, dependent: :destroy

  validates :name, uniqueness: { scope: [:genre] }

  def self.genres_from_sub_genres(artists)
    sub_genres = artists.each_with_object([]) do |artist, user_sub_genres|
      artist.user_artist_genres.each do |user_artist_sub_genre|
        user_sub_genres << user_artist_sub_genre.sub_genre.name
      end
    end

    sub_genres.map! do |sub_genre|
      Genre.includes(:sub_genres).references(:sub_genres).where(sub_genres: { name: sub_genre })
    end

    sub_genres.flatten.group_by { |i| i }.sort_by { |_, a| -a.count }.map(&:first).first(5)
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
