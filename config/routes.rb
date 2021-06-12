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

scope module: :apps do
  scope module: :myprofiles do
    resource  :profile, only: [:show, :edit, :update]
    resource  :notification, only: [:show]
    resource  :favorite, only: [:show]
    resource  :timeline, only: [:show]
    resource  :buy, only: [:show]
    resource  :myarticle, only: [:show]
    resource  :followerlist, only: [:show]
    resource  :followinglist, only: [:show]
  end
  scope module: :senjins do
    resources :rakutens, only: [:index] do
    collection do
      get 'search'
    end
    resource :buylist, only: [:create, :destroy]
    end
  end
  scope module: :other_users do
    resources  :accounts, only: [:show] do
      resource  :favorite, only: [:show]
      resource  :othertimeline, only: [:show]
      resource  :otherbuy, only: [:show]
      resource  :otherarticle, only: [:show]
      resources :follows, only: [:create]
      resources :unfollows, only: [:create]
      resources :actives, only: [:index]
      resources :passives, only: [:index]
    end
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
