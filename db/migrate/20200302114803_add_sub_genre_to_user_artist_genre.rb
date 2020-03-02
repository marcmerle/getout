class AddSubGenreToUserArtistGenre < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_artist_genres, :sub_genre, foreign_key: true
  end
end
