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
  root 'users#main'
  get 'register' => 'users#new' # show registry form
  post 'register' => 'users#create' # do register user
	get 'login' => 'sessions#new' # show login form
  post 'login' => 'sessions#create' # do login user
  get 'logout' => 'sessions#destroy' # do logout user - requires logged 
  resources :users, only: [:show, :index] # show specific user
  get 'add_key' => 'keys#create' # add new api key
  get 'remove_key' => 'keys#destroy' # remove api key
  get 'docs' => 'docs#index' # main page of documentation
  
end
