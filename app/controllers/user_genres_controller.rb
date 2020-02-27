class UserGenresController < ApplicationController
  def create
    @genre = Genre.find(params[:genre_id])
    @user_genre = UserGenre.new(genre: @genre, user: current_user)
    authorize @user_genre
    @user_genre.save
    redirect_to tastes_path
  end

  def destroy
    @genre = Genre.find(params[:genre_id])
    @user_genre = UserGenre.find_by(genre: @genre, user: current_user)
    authorize @user_genre
    @user_genre.destroy
    redirect_to tastes_path
  end
end
