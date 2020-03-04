# frozen_string_literal: true

class LikesController < ApplicationController
  def index
    if params[:tag].present?
      @likes = Like.joins(place: [place_genres: :genre])
                   .where('genres.name ILIKE ?', "%#{params[:tag]}%")
                   .where(user: current_user)
    else
      @likes = Like.where(user: current_user)
    end
    policy_scope(@likes)
    set_genres
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

  private

  def set_genres
    @genres = Like.all.each_with_object({}) do |like, collection|
      like.place.genres.each do |genre|
        collection[genre.name] = [genre, 0] unless collection.key?(genre.name)
        collection[genre.name][1] += 1
      end
    end
  end
end
