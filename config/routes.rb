Rails.application.routes.draw do
root to:'articles#index'
devise_for :users do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
resources :articles do
  resources :comments, only: [:index, :create]
  resource :like, only: [:show, :create, :destroy]
end
resource  :profile, only: [:show, :edit, :update]
resource  :favorite, only: [:show]
resources  :accounts, only: [:show] do
  resources :follows, only: [:create]
  resources :unfollows, only: [:create]
  resources :informations, only: [:index]
end
end
