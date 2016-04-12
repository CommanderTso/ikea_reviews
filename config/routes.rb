Rails.application.routes.draw do
  devise_for :users
  root "items#index"

  resources :categories, only: [:show]
  resources :items, only: [:new, :create, :index, :show] do
    resources :reviews, only: [:create, :index, :update, :delete]
  end
end
