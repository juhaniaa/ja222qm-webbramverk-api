class SessionsController < ApplicationController

  def new # show login-form    
  end
  
  def create # create new session for user
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      log_in @user # session helper
      redirect_to @user
    else
      flash[:notice] = "Login failed"
      redirect_to login_path
    end
  end
  
  def destroy
    log_out # session helper
    redirect_to root_path, notice: "Log out succesfull"
  end
end