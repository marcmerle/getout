# frozen_string_literal: true

namespace :genre do
  desc 'Seed the Genre database'
  task seed: :environment do
    genres = [
      'r&b',
      'urban',
      'hip hop',
      'soul',
      'pop',
      'dance',
      'rap',
      'funk',
      'indie',
      'blues',
      'rock',
      'trap',
      'reggae',
      'reggaeton',
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
      'prog',
      'folk',
      'experimental',
      'ambient',
      'acoustic',
      'afrobeat',
      'alternative',
      'bossanova',
      'classical',
      'deep-house',
      'disco',
      'edm',
      'electronic',
      'garage',
      'gospel',
      'goth',
      'grunge',
      'hardcore',
      'latin',
      'minimal',
      'progressive',
      'samba',
      'ska',
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
end
