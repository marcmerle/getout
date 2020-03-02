# frozen_string_literal: true

class Artist
  attr_reader :name, :picture, :photos

  def initialize(**args)
    @name = args[:name]
    @picture = args[:picture]
  end
end

class Artist
  class << self
    def seed
      [
        Artist.new(name: 'Alanis Morissette', picture: 'https://i.scdn.co/image/b62e0f5c189174ae5f53124e188ba0e1fd4af433'),
        Artist.new(name: 'Queen', picture: 'https://i.scdn.co/image/b040846ceba13c3e9c125d68389491094e7f2982'),
        Artist.new(name: 'Coldplay', picture: 'https://i.scdn.co/image/c942640d486338e4ae144a497f0cfd3f35ceb7af'),
        Artist.new(name: 'Eels', picture: 'https://i.scdn.co/image/93d37ffcc37a168fd333c1ba7119596956377a1e'),
        Artist.new(name: 'Jeff Buckley', picture: 'https://i.scdn.co/image/67779606c7f151618a28f62b1d24fb514d39dacf')
      ]
    end
  end
end
