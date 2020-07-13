Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root 'damages#index'
  resources :users
  resources :dameges
  resources :posts do 
    resource :favorites, only: [:create, :destroy]
  end
end
