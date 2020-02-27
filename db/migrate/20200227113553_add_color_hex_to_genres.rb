class AddColorHexToGenres < ActiveRecord::Migration[6.0]
  def change
    add_column :genres, :color_hex, :string
  end
end
