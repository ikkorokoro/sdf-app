Rails.application.routes.draw do
root to:'articles#index'
devise_for :users do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#new_guest'
end
resources :articles do
  collection do
    get 'search'
  end
  resources :comments, only: [:index, :create]
  resource :like, only: [:show, :create, :destroy]
end
resources :notifications, only: [:index]
resource  :profile, only: [:show, :edit, :update]
resource  :myfavorite, only: [:show]
resource  :timeline, only: [:show]
resources  :accounts, only: [:show] do
  resource  :favorite, only: [:show]
  resources :follows, only: [:create]
  resources :unfollows, only: [:create]
  resources :informations, only: [:index]
  resources :actives, only: [:index]
  resources :passives, only: [:index]
end
end
