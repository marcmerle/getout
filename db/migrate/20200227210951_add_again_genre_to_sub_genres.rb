class AddAgainGenreToSubGenres < ActiveRecord::Migration[6.0]
  def change
    add_reference :sub_genres, :genre, foreign_key: true
  end
end
