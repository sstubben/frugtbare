Rails.application.routes.draw do
  resources :ideas
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show]

  root 'main#index'
end
