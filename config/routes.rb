Rails.application.routes.draw do
  devise_for :users,
    :controllers => { registrations: "devise/custom/registrations" }
  root "items#index"
  get "/votes/upvote", to: 'votes#upvote'
  get "/votes/downvote", to: 'votes#downvote'
  get "/ajax/upvote", to: 'votes#ajax_upvote'
  get "/ajax/downvote", to: 'votes#ajax_downvote'

  resources :categories, only: [:show]
  resources :items, only: [:new, :create, :index, :show] do
    resources :reviews, only: [:create, :index, :update, :delete]
  end
  resources :admins, only: [:index]
  namespace :admins do
    resources :users, only: [:index, :destroy]
    resources :items, only: [:index, :destroy]
    resources :reviews, only: [:index, :destroy]
  end
end
