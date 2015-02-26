class KeysController < ApplicationController
  before_action :check_admin, only: [:destroy_by_admin]
  before_action :check_user, only: [:create, :destroy]
  
  # Apinyckelsmetoder
  
  def create 
    # get current user
    @user = current_user
    
    # give new apikey
    @user.apikey = Apikey.create(key: SecureRandom.hex)
    
    flash[:notice] = "A new key has been generated"
    
    redirect_to @user
  end
  
  def destroy
    # get current user
    @user = current_user
    
    # remove apikey with current users id
    @user.apikey = nil
    
    flash[:notice] = "Your key has been removed"
    
    redirect_to @user
  end
  
  def destroy_by_admin
    @user = User.find_by_id(params[:id])    
    @user.apikey = nil
    flash[:notice] = "The user's key has been removed"
    redirect_to current_admin
  end
  
end
