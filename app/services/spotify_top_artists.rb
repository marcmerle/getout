# frozen_string_literal: true

class SpotifyTopArtists < SpotifyConnector
  def initialize(user)
    super
    @end_point = 'me/top/artists?limit=20'
  end
end
