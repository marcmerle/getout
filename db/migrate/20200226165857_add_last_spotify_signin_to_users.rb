class AddLastSpotifySigninToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_spotify_signin, :timestamp
  end
end
