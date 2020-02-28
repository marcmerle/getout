class RemoveGenreFromSubGenres < ActiveRecord::Migration[6.0]
  def change

    remove_column :sub_genres, :genre_id
  end
end
