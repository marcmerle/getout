Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  resources :places, only: %i[index show]
end
