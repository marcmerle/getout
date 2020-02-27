class AddGenreToSubGenres < ActiveRecord::Migration[6.0]
  def change
    add_reference :sub_genres, :genre, null: false, foreign_key: true
  end
end
