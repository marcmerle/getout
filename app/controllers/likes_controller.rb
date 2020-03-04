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

    if params[:tag].present?
      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @place = Place.find(params[:place_id])
    @like = Like.new(place: @place, user: current_user)
    authorize @like
    @like.save
    redirect_to place_path(@place)
  end

  def destroy
    @place = Place.find(params[:place_id])
    @like = Like.find_by(place: @place, user: current_user)
    authorize @like
    @like.destroy
    redirect_to place_path(@place)
  end

  private

  def set_genres
    @genres = Like.where(user: current_user).each_with_object({}) do |like, collection|
      like.place.genres.each do |genre|
        collection[genre.name] = [genre, 0] unless collection.key?(genre.name)
        collection[genre.name][1] += 1
      end
    end
  end
end
