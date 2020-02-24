class Place < ApplicationRecord
  has_many :place_genres
  has_many :genres, through: :place_genres
  has_many_attached :photos
  validates :name, :address, presence: true
end
