class SessionsController < ApplicationController
  
   # Inloggningsmetoder
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:userid] = @user.id
      redirect_to @user
    else
      flash[:notice] = "Login failed"
      redirect_to login_path
    end
  end
  
  
  def destroy
    session[:userid] = nil
    redirect_to root_path, notice: "Log out succesfull"
  end
end
