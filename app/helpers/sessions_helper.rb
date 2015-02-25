module SessionsHelper

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
  
  def is_logged_in? # true if a user is logged in
    !current_user.nil?
  end
  
  def check_user # redirect if no user is logged in
    unless is_logged_in?
      flash[:danger] = "You need to be logged in!"
      redirect_to login_path
    end
  end
end
