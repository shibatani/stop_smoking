Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root 'damages#index'
  resources :users
  resources :dameges
  resources :posts do 
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end
end
