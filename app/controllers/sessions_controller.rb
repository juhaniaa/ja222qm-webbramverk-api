class SessionsController < ApplicationController  

  ### User
  
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
  
  ### Admin
  
  def new_admin # show admin login-form
  end
  
  def create_admin # create new session for admin
    @admin = Admin.find_by_email(params[:email])
    if @admin && @admin.authenticate(params[:password])
      log_in_admin @admin # session helper
      redirect_to @admin
    else
      flash[:notice] = "Login failed"
      redirect_to login_admin_path
    end
  end
  
  def destroy_admin
    log_out_admin # session helper
    redirect_to root_path, notice: "Log out succesfull"
  end
end