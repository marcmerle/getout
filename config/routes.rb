Rails.application.routes.draw do
  get 'user_genres/create'
  get 'user_genres/destroy'
  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/dashboard/likes', to: 'likes#index', as: "dashboard_likes"

  resources :likes, only: %i[create destroy]
  resources :user_genres, only: %i[create destroy]

  resources :places, only: %i[index show]
  get '/tastes', to: 'pages#tastes', as: 'tastes'
end
