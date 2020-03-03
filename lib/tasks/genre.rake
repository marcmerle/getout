# frozen_string_literal: true

namespace :genre do
  desc 'Seed the Genre database'
  task seed: :environment do
    genres = [
      'r&b',
      'hip-hop',
      'soul',
      'pop',
      'dance',
      'funk',
      'indie',
      'blues',
      'rock',
      'reggae',
      'jazz',
      'country',
      'techno',
      'electro',
      'house',
      'electronica',
      'dub',
      'dubstep',
      'chill',
      'punk',
      'metal',
      'folk',
      'experimental',
      'ambient',
      'afrobeat',
      'alternative',
      'classical',
      'disco',
      'latin',
      'trance',
      'world'
    ]

    hex_colors = [
      '#7FCA74',
      '#E5CE3B',
      '#FCB255',
      '#EF7A6D',
      '#CE93E7',
      '#3C93CD',
      '#46CEE7',
      '#2CA569',
      '#FB93D5',
      '#5C6A83',
      '#C2C8D1',
      '#828891'
    ]

    genres.sort.each_with_index { |genre, i| Genre.create(name: genre, color_hex: hex_colors[i % hex_colors.size]) }
  end

  task sub_seed: :environment do
    require 'yaml'
    sub_genres = YAML.safe_load(File.read('lib/genres.yml'))

    sub_genres.each { |sub_genre| SubGenre.create_and_match(sub_genre) }
  end
end
