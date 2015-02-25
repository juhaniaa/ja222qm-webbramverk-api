class KeysController < ApplicationController
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
end
