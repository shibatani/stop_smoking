Rails.application.routes.draw do
  devise_for :users
  root 'damages#index'
  resources :users
  resources :dameges
end
