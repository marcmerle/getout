# frozen_string_literal: true

require 'open-uri'

class String
  def green
    "\e[32m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end
end

Geocoder.configure(timeout: 60, lookup: :ban_data_gouv_fr)

`rails genre:seed`
puts "\n#{Genre.count} genres were created\n".green

`rails genre:sub_seed`
puts "\n#{SubGenre.count} sub_genres were created\n".green

PLACE_GENRES = []

PLACE_GENRES.fill(
  [Genre.find_by(name: 'ambient'), Genre.find_by(name: 'chill')],
  PLACE_GENRES.size,
  10
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'house'), Genre.find_by(name: 'techno')],
  PLACE_GENRES.size,
  10
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'pop'), Genre.find_by(name: 'dance')],
  PLACE_GENRES.size,
  5
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'metal'), Genre.find_by(name: 'punk')],
  PLACE_GENRES.size,
  10
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'dub'), Genre.find_by(name: 'dubstep')],
  PLACE_GENRES.size,
  5
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'dub'), Genre.find_by(name: 'reggae')],
  PLACE_GENRES.size,
  5
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'latin'), Genre.find_by(name: 'world')],
  PLACE_GENRES.size,
  10
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'indie'), Genre.find_by(name: 'world')],
  PLACE_GENRES.size,
  5
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'soul'), Genre.find_by(name: 'blues')],
  PLACE_GENRES.size,
  8
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'rock'), Genre.find_by(name: 'blues')],
  PLACE_GENRES.size,
  8
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'chill'), Genre.find_by(name: 'electronica')],
  PLACE_GENRES.size,
  4
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'dance'), Genre.find_by(name: 'pop')],
  PLACE_GENRES.size,
  5
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'electro')],
  PLACE_GENRES.size,
  6
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'electronica'), Genre.find_by(name: 'electro')],
  PLACE_GENRES.size,
  8
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'hip-hop')],
  PLACE_GENRES.size,
  16
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'house'), Genre.find_by(name: 'electro')],
  PLACE_GENRES.size,
  10
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'jazz')],
  PLACE_GENRES.size,
  16
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'pop')],
  PLACE_GENRES.size,
  16
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'r&b'), Genre.find_by(name: 'hip-hop')],
  PLACE_GENRES.size,
  8
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'rock'), Genre.find_by(name: 'pop')],
  PLACE_GENRES.size,
  8
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'rock')],
  PLACE_GENRES.size,
  16
)

PLACE_GENRES.fill(
  [Genre.find_by(name: 'techno'), Genre.find_by(name: 'electro')],
  PLACE_GENRES.size,
  15
)

Genre.all.each do |genre|

  PLACE_GENRES.fill(
    [genre],
    PLACE_GENRES.size,
    4
  )

end

places_file = File.read('db/places.json')
places_data = JSON.parse(places_file)

##
# Place DB Seed

places_data.each_with_index do |place_data, i|
  place = Place.new(
    name: place_data['name'],
    address: place_data['geoloc_address'],
    description: Faker::Restaurant.description,
    category: 'bar',
    opening_start: Time.gm(2000, 'jan', 1, rand(17..20)),
    opening_end: Time.gm(2000, 'jan', 1, rand(21..23)),
    avg_rating: rand(3.5..5.0).round(1)
  )

  place_data['pictures'].each_with_index do |place_picture, i|
    url = place_picture['picture_file']['url']
    file = URI.open(url)
    place.photos.attach(io: file, filename: "place_#{place.id}_#{i + 1}.png", content_type: 'image/png')
  end

  place.save!

  downcase_name = place.name.downcase

  Genre.all.each do |genre|
    PlaceGenre.create(place: place, genre: genre) if downcase_name.match(/#{genre.name}/)
  end

  if place.place_genres.count == 0
    PLACE_GENRES.sample.each { |genre| PlaceGenre.create(place: place, genre: genre) }
  end

  puts "Place ##{i + 1} was created (#{place.photos.count} picture(s) with #{place.genres.count} genres)".blue
end
puts "\n#{Place.count} places were created\n".green
