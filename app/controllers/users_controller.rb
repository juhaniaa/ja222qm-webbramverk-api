class UsersController < ApplicationController  
 # before_action :require_login, except: [:index, :new, :create, :login]
  before_action :check_user, except: [:main, :new, :create]
  
  def main
    # if user is logged in, redirect to user-infopage
    # redirect_to @user
    # else render main page
  end
  
  def new
    # show registry form
    @user = User.new
  end
  
  def create
    # create user with post params
    @user = User.new(user_params)
    
    if @user.save
      # store session
      ## session[:userid] = @user.id
      redirect_to @user
    else
      # show registry form with errors
      render action: :new
      # or? redirect_to register_path
    end
  end

  def show
    # get current user        
    @user = current_user
    
    # check if correct user
  end 
  
  private
 
  # allowed parameters when creating account
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end  
end
