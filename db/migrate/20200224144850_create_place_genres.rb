class CreatePlaceGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :place_genres do |t|
      t.float :broadcasting_percentage
      t.references :place, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
