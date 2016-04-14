Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items, only: [:new, :create, :index, :show] do
    resources :reviews, only: [:create, :update]
  end
  resources :reviews, only: [:edit, :destroy]
  resources :admins, only: [:index]
  namespace :admins do
    resources :users, only: [:index, :destroy]
    resources :items, only: [:index, :destroy]
    resources :reviews, only: [:index, :destroy]
  end
end
