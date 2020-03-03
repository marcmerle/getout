class LikesController < ApplicationController
  def index
    if params[:query].present?
      @likes = Like.join(places: [place_genres: :genres])
                   .where('genres.name ILIKE ?', "%#{params[:query]}%")
    else
      @likes = policy_scope(Like)
    end
    filter_by_tags
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

  def filter_by_tags
    @genres = []
    @likes.each do |like|
      like.place.genres.map do |genre|
        @genres << genre.name
      end
    end
  end
end
