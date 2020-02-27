class AddViewedTagScreenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :viewed_tag_screen, :boolean
  end
end
