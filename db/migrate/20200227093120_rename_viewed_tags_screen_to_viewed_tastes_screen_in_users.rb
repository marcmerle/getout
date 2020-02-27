class RenameViewedTagsScreenToViewedTastesScreenInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :viewed_tag_screen, :viewed_tastes_screen
  end
end
