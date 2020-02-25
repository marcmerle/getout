class ChangeTypeToCategoryInPlaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :places, :type, :category
  end
end
