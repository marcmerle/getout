# frozen_string_literal: true

class SubGenre < ApplicationRecord
  belongs_to :genre

  def self.create_and_match(sub_genre)
    Genre.find_each do |genre|
      next unless sub_genre.match?(genre.name)

      create(name: sub_genre, genre: genre)
    end
  end
end
