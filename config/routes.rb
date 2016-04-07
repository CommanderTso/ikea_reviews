Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items, only: [:new, :create, :index, :show]
  resources :admins, only: [:index]
  namespace :admins do
    resources :users, only: [:index]
    resources :items, only: [:index]
    resources :reviews, only: [:index]
  end
end
