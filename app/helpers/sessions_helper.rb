module SessionsHelper

  ### User
  
  def log_in(user) # store user_id in session
    session[:user_id] = user.id
  end
  
  def log_out # remove session and current user
    session.delete(:user_id)
    @current_user = nil
  end
  
  def current_user # get current user from variable or session
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def user_logged_in? # true if a user is logged in
    !current_user.nil?
  end
  
  def check_user # redirect if no user is logged in
    unless user_logged_in?
      flash[:danger] = "You need to be logged in!"
      redirect_to login_path
    end
  end
  
  ### Admin
  
  def log_in_admin(admin) # store admin_id in session
    session[:admin_id] = admin.id
  end
  
  def log_out_admin # remove session and current admin
    session.delete(:admin_id)
    @current_admin = nil
  end
  
  def current_admin # get current admin from variable or session
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end
  
  def admin_logged_in? # true if a admin is logged in
    !current_admin.nil?
  end
  
  def check_admin # redirect if no admin is logged in
    unless admin_logged_in?
      flash[:danger] = "You need to be logged in!"
      redirect_to login_admin_path
    end
  end 
end
