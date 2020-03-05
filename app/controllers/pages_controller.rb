# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  # rubocop:disable Metrics/MethodLength
  # SQL Query makes the method too long for Rubocop
  def home
    return unless current_user

    @places = if current_user.genres.present?
                sql = <<-SQL
                      SELECT pg.place_id FROM user_genres AS ug
                      LEFT JOIN place_genres AS pg ON pg.genre_id = ug.genre_id
                      WHERE ug.user_id = #{current_user.id}
                      GROUP BY 1
                      LIMIT 30;
                SQL
                results = ActiveRecord::Base.connection.execute(sql)
                place_ids = results.pluck('place_id')

                policy_scope(Place).where(id: place_ids).sample(8)
              else
                policy_scope(Place).sample(8)
              end

    @artists = current_user.user_artists

    here = Geocoder.search('52 ter Rue des Vinaigriers 75010 Paris').first.coordinates
    @places_nearby = policy_scope(Place)
                     .select { |place| place.distance_to(here, :km) < 2 }
                     .sample(8)
  end
  # rubocop:enable Metrics/MethodLength

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
end
