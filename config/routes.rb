Rails.application.routes.draw do

  devise_for :users

  root 'tops#index'

  resources :users do 
    get :search, on: :collection
  end

  resources :posts do 
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :notifications, only: :index
end