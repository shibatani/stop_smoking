Rails.application.routes.draw do

  root 'tops#index'

  devise_for :users

  resources :users do 
    get :search, on: :collection
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :posts do 
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end

  resources :notifications, only: :index
end