Rails.application.routes.draw do
  resources :ideas
  devise_for :users
  resources :users, only: [:index]

  root 'main#index'
end
