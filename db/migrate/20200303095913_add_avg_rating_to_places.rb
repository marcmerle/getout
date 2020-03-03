class AddAvgRatingToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :avg_rating, :float
  end
end
