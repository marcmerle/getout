class CreateUserLikesPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :user_likes_places do |t|
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      t.boolean :liked, default: false

      t.timestamps
    end
  end
end
