class ChangeNameTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_likes_places, :likes
  end
end
