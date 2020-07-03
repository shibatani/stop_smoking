Rails.application.routes.draw do
  devise_for :users
  root 'smokers#index'
  resources :smokers
end
