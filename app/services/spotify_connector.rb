# frozen_string_literal: true

class SpotifyConnector < ApplicationService
  private

  attr_accessor :auth, :base_url, :end_point

  public

  def initialize(user)
    @auth = "Bearer #{user.access_token}"
    @base_url = 'https://api.spotify.com/v1/'
  end

  def call
    JSON.parse(api_call.body)
  end

  private

  def api_call
    HTTParty.get(base_url + end_point,
                 headers: {
                   Authorization: auth
                 })
  end
end
