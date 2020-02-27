class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home; end

  def tastes
    current_user.viewed_tastes_screen = true
    @color = 'ef798a'
  end
end
