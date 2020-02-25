# frozen_string_literal: true

class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
    authorize @place
  end
end
