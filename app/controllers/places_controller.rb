# frozen_string_literal: true

class PlacesController < ApplicationController
  after_action :verify_authorized, except: %i[index home genres], unless: :skip_pundit?

  def index
    @query = params[:query].presence || '52 ter Rue des Vinaigriers 75010 Paris'
    @query_coordinates = Geocoder.search(@query).first.coordinates

    place_ids = policy_scope(Place)
                .joins(place_genres: { genre: :user_genres })
                .pluck(:id)

    @places = policy_scope(Place)
              .where(id: place_ids)
              .sort_by { |place| place.distance_to(@query_coordinates, :km) }

    add_markers_on_map
    add_curent_position_on_map
  end

  def show
    @place = Place.find(params[:id])
    @like = Like.where(user: current_user, place: @place).first
    authorize @place
  end

  def genres
    @query_genres = params[:query_genres].split(' ')
    @genres = Genre.where(name: @query_genres.map(&:downcase))
    @places = Place.joins(:place_genres).where(place_genres: { genre_id: @genres.pluck(:id) })

    render layout: false
  end

  private

  def add_markers_on_map
    @markers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { place: place }),
        image_url: helpers.asset_url('marker.png')
      }
    end
  end

  def add_curent_position_on_map
    @markers << {
      lat: @query_coordinates.first,
      lng: @query_coordinates.last,
      image_url: helpers.asset_url('marker_own.png')
    }
  end
end
