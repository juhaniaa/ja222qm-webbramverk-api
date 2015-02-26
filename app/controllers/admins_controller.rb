class AdminsController < ApplicationController
  before_action :check_admin
  
  def show
    # get current user        
    @admin = current_admin
    
    # check if correct user
  end 
end
