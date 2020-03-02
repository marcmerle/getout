class CreateUserArtistGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :user_artist_genres do |t|
      t.references :user_artist, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
