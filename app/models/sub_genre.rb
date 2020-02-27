# frozen_string_literal: true

class SubGenre < ApplicationRecord
  belongs_to :genre, optional: true
  validates :name, uniqueness: { scope: [:genre_id] }

  def self.create_and_match(sub_genre)
    puts sub_genre
    modified_sub_genre = sub_genre.gsub('hip hop', 'hip-hop')
    modified_sub_genre.gsub!('rap', 'hip-hop')
    modified_sub_genre.gsub!('thip-hop', 'trap')
    has_genre = false
    Genre.find_each do |genre|
      puts "---------- try genre #{genre.name}"
      next unless modified_sub_genre.match?(genre.name)
      has_genre = true
      puts "-----------------------match: #{has_genre}"
      create(name: sub_genre, genre: genre)
    end
    puts has_genre
    create(name: sub_genre) unless has_genre
  end
end
