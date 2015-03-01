require 'api_constraints'

Rails.application.routes.draw do
  
  # API routes
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :events        
      resources :tags do
        resources :events, only: [:index]
      end
      resources :hunters do
        resources :events, only: [:index]
      end
    end
    #scope module: :v2, constraints: ApiConstraints.new(version: 2, default: true) do
      #resources :events
    #end
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
  
  # Admin routes  
  get 'login_admin' => 'sessions#new_admin' # show admin login-form
  post 'login_admin' => 'sessions#create_admin' # do login admin
  get 'logout_admin' => 'sessions#destroy_admin' # do logout admin - requires logged
  resources :admins, only: [:show, :index] # show specific admin  
  get  "keys/remove/:id" => "keys#destroy_by_admin", as: :remove_key_by_admin # admin removes a users apikey
  
  
end
