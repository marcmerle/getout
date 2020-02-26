# frozen_string_literal: true

module GravatarHelper
  def gravatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png" # ?d=DEFAULT_IMAGE
  end
end
