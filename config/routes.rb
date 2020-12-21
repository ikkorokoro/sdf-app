Rails.application.routes.draw do
root to:'homes#index'
devise_for :users do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
end
