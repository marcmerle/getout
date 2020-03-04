# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/dashboard/likes', to: 'likes#index', as: 'dashboard_likes'

  get 'likes/create' # Do not remove
  get 'likes/destroy' # Do not remove
  resources :likes, only: %i[create destroy]

  get 'user_genres/create' # Do not remove
  get 'user_genres/destroy' # Do not remove
  resources :user_genres, only: %i[create destroy]

  get 'places/genres', to: 'places#genres', as: 'places_genres'
  resources :places, only: %i[index show]

  get '/location', to: 'pages#location', as: 'location'

  get '/tastes', to: 'pages#tastes', as: 'tastes'
end
