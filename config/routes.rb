# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/dashboard/likes', to: 'likes#index', as: 'dashboard_likes'

  resources :likes, only: %i[create destroy]
  resources :user_genres, only: %i[create destroy]

  resources :places, only: %i[index show]

  get '/tastes', to: 'pages#tastes', as: 'tastes'
  get '/loading', to: 'pages#loading', as: 'loading'
end
