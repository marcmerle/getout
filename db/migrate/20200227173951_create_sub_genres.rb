# frozen_string_literal: true

class CreateSubGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_genres do |t|
      t.string :name
      t.timestamps
    end
  end
end
