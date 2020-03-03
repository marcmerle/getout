require 'json'
require 'net/http'

places_file = File.read('db/places.json')
places_data = JSON.parse(places_file)

wrong_bars = []

places_data.each do |place_data|
  place_data['pictures'].each do |picture|
    h = Net::HTTP.get_response(URI(picture['picture_file']['url']))
    wrong_bars << place_data['name'] if h.code.to_s != "200"
    p wrong_bars if h.code.to_s != "200"
    p h.code
  end
end

p wrong_bars.uniq
