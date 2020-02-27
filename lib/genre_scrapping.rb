# frozen_string_literal: true

require 'yaml'
require 'nokogiri'
require 'open-uri'

url = 'http://everynoise.com/everynoise1d.cgi?scope=all'
document = Nokogiri::HTML(open(url), nil, 'utf8')

genres = document.search('td.note > a').map(&:text)

File.open('genres.yml', 'w') { |file| file.write(genres.to_yaml) }
