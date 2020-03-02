class UserArtistGenre < ApplicationRecord
  belongs_to :user_artist
  belongs_to :sub_genre
end
