Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :places, only: %i[index show]
  get '/tastes', to: 'pages#tastes', as: 'tastes'
end
