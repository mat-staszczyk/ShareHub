Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :things, only: [:create, :index, :new]
  resources :transactions, only: [:create, :index, :new]
end
