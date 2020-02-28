# frozen_string_literal: true

class PlacesController < ApplicationController
  def index
    @query = params[:query]
    @places = @query.present? ? compute_policy_scope : matching_places(policy_scope(Place))
    compute_distance if @query.present?
  end

  def show
    @place = Place.find(params[:id])
    @like = Like.where(user: current_user, place: @place).first
    authorize @place
  end

  private

  def compute_policy_scope(distance = 1)
    place_distance = Place.near(@query, 10)
    if place_distance.present?
      matching_places(policy_scope(place_distance))
    else
      new_dist = distance < 5 ? 1 : 100
      set_policy_scope(distance + new_dist)
    end
  end

  def compute_distance
    position = Geocoder.search(@query).first
    @places.each do |place|
      place.distance = (1_000 * Geocoder::Calculations.distance_between(
        position.coordinates,
        [place.latitude, place.longitude]
      )).round
    end
  end

  def matching_places(scope)
    sql = <<-SQL
      SELECT pg.place_id FROM user_genres AS ug
      LEFT JOIN place_genres AS pg ON pg.genre_id = ug.genre_id
      WHERE ug.user_id = #{current_user.id}
      GROUP BY 1;
    SQL
    results = ActiveRecord::Base.connection.execute(sql)
    places = Place.find(results.map { |x| x['place_id'] })
    scope.select { |place| places.include? place }
  end
end
