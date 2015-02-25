class KeysController < ApplicationController
  # Apinyckelsmetoder
  
  def create 
    # get current user
    # @user = User.find_by_id(session[:userid])
    
    # give new apikey
    
    #if true
     # flash[:notice] = "A new key has been generated"
    #else
    #  flash[:notice] = "There was a problem when generating your new key"
    #end       
    redirect_to @user
  end
  
  def destroy
    # get current user
    # @user = User.find_by_id(session[:userid])
    
    # remove apikey with current users id
    
    #if @user.update_attribute(:apikey,nil)
     # flash[:notice] = "Nyckeln togs bort"
    #else
    #  flash[:notice] = "Fel uppstod"
    #end
    redirect_to @user
  end
end
