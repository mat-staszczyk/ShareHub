require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#home'

  resources :things, only: [:create, :index, :new, :show]
  resources :transactions, only: [:create, :index, :new]
end
