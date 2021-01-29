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
resource  :myfavorite, only: [:show]
resources  :accounts, only: [:show] do
  resource  :favorite, only: [:show]
  resources :follows, only: [:create]
  resources :unfollows, only: [:create]
  resources :informations, only: [:index]
  resources :actives, only: [:index]
  
end
end
