Rails.application.routes.draw do
  resources :ideas
  devise_for :users
  resources :users, only: [:index, :show]

  root 'main#index'
end
