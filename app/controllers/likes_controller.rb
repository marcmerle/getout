class LikesController < ApplicationController
  def index
    @likes = policy_scope(Like)
  end

  def create
    @place = Place.find(params[:place_id])
    @like = Like.create(place: @place, user: current_user, liked: true)
    authorize @like
    redirect_to place_path(@place)
  end

  def destroy
    @like = Like.find(params[:id])
    @place = @like.place
    authorize @like
    @like.destroy
    redirect_to place_path(@place)
  end

end
