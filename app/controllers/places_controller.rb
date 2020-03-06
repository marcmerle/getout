# frozen_string_literal: true

class PlacesController < ApplicationController
  after_action :verify_authorized, except: %i[index home genres], unless: :skip_pundit?

  # rubocop:disable Metrics/MethodLength
  # SQL Query makes the method too long for Rubocop
  def index
    @query = params[:query].presence || '52 ter Rue des Vinaigriers 75010 Paris'
    @query_coordinates = Geocoder.search(@query).first.coordinates

    sql = <<-SQL
          SELECT pg.place_id FROM user_genres AS ug
          LEFT JOIN place_genres AS pg ON pg.genre_id = ug.genre_id
          WHERE ug.user_id = #{current_user.id}
          GROUP BY 1
          LIMIT 30;
    SQL
    results = ActiveRecord::Base.connection.execute(sql)
    place_ids = results.pluck('place_id')

    @places = policy_scope(Place)
              .where(id: place_ids)
              .sort_by { |place| place.distance_to(@query_coordinates, :km) }

    add_markers
  end
  # rubocop:enable Metrics/MethodLength

  def show
    @place = Place.find(params[:id])
    @like = Like.where(user: current_user, place: @place).first
    authorize @place
  end

  def genres
    @query_genres = params[:query_genres].split(' ')
    @genres = Genre.all.where('name IN (?)', @query_genres.map(&:downcase))

    sql = <<-SQL
        INNER JOIN place_genres ON place_genres.place_id = places.id
          AND place_genres.genre_id IN (#{@genres.map(&:id).join(',')})
        LIMIT 30
    SQL

    @places = Place.joins(sql)

    render layout: false
  end

  private

  def add_markers
    @markers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { place: place }),
        image_url: helpers.asset_url('marker.png')
      }
    end
    @markers << {
      lat: @query_coordinates.first,
      lng: @query_coordinates.last,
      image_url: helpers.asset_url('marker_own.png')
    }
  end
end
