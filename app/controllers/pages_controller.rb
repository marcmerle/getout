class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home; end

  def tastes
    current_user.viewed_tastes_screen = true
    current_user.save
    @genres = Genre
              .all
              .select("genres.*, user_genres.user_id")
              .joins("left join user_genres on user_genres.genre_id = genres.id and user_genres.user_id = #{current_user.id}")
              .order('user_genres.user_id, genres.name ASC')
  end
end
