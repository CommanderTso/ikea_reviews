Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items, only: [:new, :create, :index, :show]
  resources :admins, only: [:index]
  namespace :admins do
    resources :users, only: [:index, :destroy]
    resources :items, only: [:index, :destroy]
    resources :reviews, only: [:index]
  end
end
