# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.save
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Spotify') if is_navigational_format?
    else
      session['devise.spotify_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:notice] = 'The signin procedure did not work out, please retry or contact us if involontary.'
    redirect_to root_path
  end
end
