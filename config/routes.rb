require 'api_constraints'

Rails.application.routes.draw do
  
  # API routes
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :events
    end
    scope module: :v1, constraints: ApiConstraints.new(version: 2, default: true) do
      resources :events
    end
  end
  
  # Registration routes
  root 'users#index'
  get 'register' => 'users#new' # show registry form
  post 'register' => 'users#create' # do register user
	get 'login' => 'sessions#new' # show login form
  post 'login' => 'sessions#create' # do login user
  get 'logout' => 'sessions#destroy' # do logout user
	resources :users, only: [:index, :show]
	resources :keys, only: [:create, :destroy]
  
end
