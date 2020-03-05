# frozen_string_literal: true

class PlacesController < ApplicationController
  after_action :verify_authorized, except: %i[index home genres], unless: :skip_pundit?

  def index
    @query = params[:query]
    current_scope = policy_scope(Place)
    current_scope = Place.policy_scope_by_distance(@query, current_scope) if @query.present?

    @places = Place.policy_scope_by_genre(current_user, current_scope)
    @query_coordinates = Geocoder.search('52 ter Rue des Vinaigriers 75010 Paris').first.coordinates

    if @query.present?
      @query_coordinates = Geocoder.search(@query).first.coordinates
      @places = @places.each { |place| place.distance_from(@query) }
                       .sort_by(&:distance)
    end

    add_markers
  end

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
  end
end
