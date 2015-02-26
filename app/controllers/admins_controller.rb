class AdminsController < ApplicationController
  before_action :check_admin
  
  def show
    # get current user        
    @admin = current_admin
    
    # get all api-keys
    @keys = Apikey.all    
    
    # check if correct user
  end 
end
