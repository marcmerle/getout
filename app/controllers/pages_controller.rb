# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if current_user
      current_scope = policy_scope(Place)
      current_scope_genre = Place.policy_scope_by_genre(current_user, current_scope) if current_user.genres.present?

      @places = current_scope_genre.sample(8)

      @artists = current_user.user_artists
      # To be replaced by proper HTML 5 geolocation at some point
      location = '52 ter Rue des Vinaigriers 75010 Paris'
      @places_nearby = Place.policy_scope_by_distance(location, current_scope).sample(8)
    end
  end

  def tastes
    current_user.viewed_tastes_screen = true
    current_user.save

    sql = <<-SQL
        LEFT JOIN user_genres
          ON user_genres.genre_id = genres.id
          AND user_genres.user_id = #{current_user.id}
    SQL

    @genres = Genre.all.select('genres.*, user_genres.user_id')
                   .joins(sql).order('user_genres.user_id, genres.name ASC')
  end

  def location
    @query_location = params[:query_location].split(' ').map(&:to_f)
    results = Geocoder.search(@query_location)

    render json: { address: results.first.address }
  end

  def loading
  end
end
