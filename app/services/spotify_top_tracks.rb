# frozen_string_literal: true

class SpotifyTopTracks < SpotifyConnector
  def initialize(user)
    super
    @end_point = 'me/top/tracks'
  end
end
