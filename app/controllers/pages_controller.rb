# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    current_scope = policy_scope(Place)
    current_scope = Place.policy_scope_by_genre(current_user, current_scope) if current_user&.genres.present?

    @places = current_scope.sample(8)
  end

  def tastes
    current_user.viewed_tastes_screen = true

    sql = <<-SQL
        LEFT JOIN user_genres
          ON user_genres.genre_id = genres.id
          AND user_genres.user_id = #{current_user.id}
    SQL

    current_user.save
    @genres = Genre.all.select('genres.*, user_genres.user_id')
                   .joins(sql).order('user_genres.user_id, genres.name ASC')
  end
end
