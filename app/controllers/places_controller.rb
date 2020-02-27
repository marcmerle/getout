# frozen_string_literal: true

class PlacesController < ApplicationController
  def index
    @places = policy_scope(Place)
  end

  def show
    @place = Place.find(params[:id])
    @like = Like.where(user: current_user, place: @place).first
    authorize @place
  end
end
