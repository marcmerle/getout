# frozen_string_literal: true

class UserGenre < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  validates :user, uniqueness: { scope: [:genre] }
end
