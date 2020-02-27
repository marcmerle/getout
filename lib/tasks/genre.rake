# frozen_string_literal: true

namespace :genre do
  desc 'Seed the Genre database'
  task seed: :environment do
    genres = [
      'acoustic', 'afrobeat', 'alt-rock', 'alternative', 'ambient', 'anime', 'black-metal', 'bluegrass',
      'blues', 'bossanova', 'brazil', 'breakbeat', 'british', 'cantopop', 'chicago-house', 'children',
      'chill', 'classical', 'club', 'comedy', 'country', 'dance', 'dancehall', 'death-metal',
      'deep-house', 'detroit-techno', 'disco', 'disney', 'drum-and-bass', 'dub', 'dubstep', 'edm',
      'electro', 'electronic', 'emo', 'folk', 'forro', 'french', 'funk', 'garage',
      'german', 'gospel', 'goth', 'grindcore', 'groove', 'grunge', 'guitar', 'happy',
      'hard-rock', 'hardcore', 'hardstyle', 'heavy-metal', 'hip-hop', 'holidays', 'honky-tonk', 'house',
      'idm', 'indian', 'indie', 'indie-pop', 'industrial', 'iranian', 'j-dance', 'j-idol',
      'j-pop', 'j-rock', 'jazz', 'k-pop', 'kids', 'latin', 'latino', 'malay',
      'mandopop', 'metal', 'metal-misc', 'metalcore', 'minimal-techno', 'movies', 'mpb', 'new-age',
      'new-release', 'opera', 'pagode', 'party', 'philippines-opm', 'piano', 'pop', 'pop-film',
      'post-dubstep', 'power-pop', 'progressive-house', 'psych-rock', 'punk', 'punk-rock', 'r-n-b', 'rainy-day',
      'reggae', 'reggaeton', 'road-trip', 'rock', 'rock-n-roll', 'rockabilly', 'romance', 'sad',
      'salsa', 'samba', 'sertanejo', 'show-tunes', 'singer-songwriter', 'ska', 'sleep', 'songwriter',
      'soul', 'soundtracks', 'spanish', 'study', 'summer', 'swedish', 'synth-pop', 'tango',
      'techno', 'trance', 'trip-hop', 'turkish', 'work-out', 'world-music'
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

    sub_genres.each do |sub_genre|
      sub_genre.gsub!('&', '-n-')
      sub_genre.gsub!('hip hop', 'hip-hop')
      sub_genre.gsub!('rap', 'hip-hop')

      SubGenre.create_and_match(sub_genre)
    end
  end
end
