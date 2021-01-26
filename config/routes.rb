Rails.application.routes.draw do
root to:'articles#index'
devise_for :users do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
resources :articles do
  resources :comments
end
resource  :profile, only: [:show, :edit, :update]
end
