class RemoveNameFromUserArtistGenre < ActiveRecord::Migration[6.0]
  def change

    remove_column :user_artist_genres, :name, :string
  end
end
