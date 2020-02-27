Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/dashboard/likes', to: 'likes#index', as: "dashboard_likes"

  resources :likes, only: %i[create destroy]
  resources :places, only: %i[index show]
end
