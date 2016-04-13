Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  get "/votes/upvote", to: 'votes#upvote'
  get "/votes/downvote", to: 'votes#downvote'

  resources :items, only: [:new, :create, :index, :show] do
    resources :reviews, only: [:create, :index, :update, :delete]
  end
end
