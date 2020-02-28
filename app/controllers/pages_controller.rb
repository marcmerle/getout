# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if current_user.genres.present?
      sql = <<-SQL
        SELECT pg.place_id FROM user_genres AS ug
        LEFT JOIN place_genres AS pg ON pg.genre_id = ug.genre_id
        WHERE ug.user_id = #{current_user.id}
        GROUP BY 1;
      SQL

      results = ActiveRecord::Base.connection.execute(sql)
      @places = Place.find(results.map { |x| x['place_id'] }).sample(8)
    else
      @places = Place.limit(8)
    end

    @places.each { |place| authorize(place) }
  end

  def tastes
    current_user.viewed_tastes_screen = true
    current_user.add_spotify_genres

    current_user.save
    @genres = Genre
              .all
              .select('genres.*, user_genres.user_id')
              .joins("left join user_genres on user_genres.genre_id = genres.id and user_genres.user_id = #{current_user.id}")
              .order('user_genres.user_id, genres.name ASC')
  end
end
