# frozen_string_literal: true

class SubGenre < ApplicationRecord
  belongs_to :genre
  validates :name, uniqueness: { scope: [:genre_id] }

  def self.create_and_match(sub_genre)
    Genre.find_each do |genre|
      next unless sub_genre.match?(genre.name)

      create(name: sub_genre, genre: genre)
    end

    create(name: sub_genre) unless find_by(name: sub_genre)
  end
end
