# frozen_string_literal: true

class SubGenre < ApplicationRecord
  belongs_to :genre, optional: true
  validates :name, uniqueness: { scope: [:genre_id] }

  def self.create_and_match(sub_genre)
    modified_sub_genre = sub_genre.gsub('hip hop', 'hip-hop')
    modified_sub_genre.gsub!('rap', 'hip-hop')
    modified_sub_genre.gsub!('thip-hop', 'trap')
    has_genre = false
    Genre.find_each do |genre|
      next unless modified_sub_genre.match?(genre.name)

      has_genre = true
      create(name: sub_genre, genre: genre)
    end
    create(name: sub_genre) unless has_genre
  end
end
