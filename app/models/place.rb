# frozen_string_literal: true

class Place < ApplicationRecord
  geocoded_by :address

  has_many :likes, dependent: :destroy, inverse_of: :places
  has_many :place_genres, dependent: :destroy, inverse_of: :places
  has_many :genres, through: :place_genres
  has_many_attached :photos
  validates :name, :address, presence: true
  after_validation :geocode, if: :will_save_change_to_address?
end
