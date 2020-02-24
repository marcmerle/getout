class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :type
      t.text :description
      t.time :opening_start
      t.time :opening_end

      t.timestamps
    end
  end
end
