# frozen_string_literal: true

class AddAccessTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :access_token, :string
    add_column :users, :refresh_token, :string
  end
end
