class CreateUserArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :user_artists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :image_url

      t.timestamps
    end
  end
end
