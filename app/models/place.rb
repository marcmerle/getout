# frozen_string_literal: true

class Place < ApplicationRecord
  has_many :likes, dependent: :destroy, inverse_of: :places
  has_many :place_genres, dependent: :destroy, inverse_of: :places
  has_many :genres, through: :place_genres
  has_many_attached :photos
  validates :name, :address, presence: true
end
