class RemoveAddLastSpotifySigninToFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :last_spotify_signin, :timestamp
  end
end
