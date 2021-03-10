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
end
resources :notifications, only: [:index]

scope module: :apps do
  scope module: :myprofs do
    resource  :profile, only: [:show, :edit, :update]
    resource  :myfavorite, only: [:show]
    resource  :timeline, only: [:show]
  end
  resources  :accounts, only: [:show] do
    resource  :favorite, only: [:show]
    resource  :othertimeline, only: [:show]
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
    resources :actives, only: [:index]
    resources :passives, only: [:index]
  end
end
namespace :api, defaluts: [format: :json] do
  scope '/articles/:article_id' do
    resources :comments, only: [:index, :create, :destroy]
    resource :like, only: [:show, :create, :destroy]
  end
    scope '/accounts/:account_id' do
      resources :informations, only: [:index]
    end
  end
end
