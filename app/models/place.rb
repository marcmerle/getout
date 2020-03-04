# frozen_string_literal: true

class Place < ApplicationRecord
  geocoded_by :address

  has_many :likes, dependent: :destroy
  has_many :place_genres, dependent: :destroy
  has_many :genres, through: :place_genres
  has_many_attached :photos
  validates :name, :address, presence: true
  after_validation :geocode, if: :will_save_change_to_address?

  attr_accessor :distance

  def distance_from(location)
    position = Geocoder.search(location).first
    self.distance = (1_000 * Geocoder::Calculations.distance_between(
      position.coordinates,
      [latitude, longitude]
    )).round
  end
end

##
# Class Methods
class Place
  class << self
    def policy_scope_by_distance(location, current_scope, distance = 5)
      current_scope if distance > 250

      near_places = near(location, distance)

      if near_places.present?
        current_scope.where(id: near_places.map(&:id))
      else
        new_dist = distance < 10 ? 1 : 100
        policy_scope_by_distance(location, current_scope, distance + new_dist)
      end
    end

    def policy_scope_by_genre(user, current_scope)
      sql = <<-SQL
          SELECT pg.place_id FROM user_genres AS ug
          LEFT JOIN place_genres AS pg ON pg.genre_id = ug.genre_id
          WHERE ug.user_id = #{user.id}
          GROUP BY 1;
      SQL
      results = ActiveRecord::Base.connection.execute(sql)
      place_ids = results.pluck('place_id')

      current_scope.where(id: place_ids)
    end
  end
end
