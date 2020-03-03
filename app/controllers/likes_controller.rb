class LikesController < ApplicationController
  def index
    if params[:tag].present?
      @likes = Like.joins(place: [place_genres: :genre])
                   .where('genres.name ILIKE ?', "%#{params[:tag]}%")
      policy_scope(@likes)
    else
      @likes = policy_scope(Like)
    end
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
    @genres = {}
    Like.all.each do |like|
      like.place.genres.each do |genre|
        @genres[genre.name] = [genre] unless @genres.has_key?(genre.name)
        @genres[genre.name] << like.place
      end
    end
  end
end
