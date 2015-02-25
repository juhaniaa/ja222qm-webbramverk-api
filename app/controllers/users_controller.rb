class UsersController < ApplicationController  
 # before_action :require_login, except: [:index, :new, :create, :login]
  
  def main
    # if user is logged in, redirect to user-infopage
    # else render main page
  end
  
  
  def index
    if session[:userid]
      u = User.find_by_id(session[:userid])
      if u
        redirect_to u      
      else
        session[:userid] = nil
      end
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    # skapa användare utifrån inskickat formulär
    @user = User.new(user_params)
    
    if @user.save
      session[:userid] = @user.id
      redirect_to @user
    else
      render action: :new
    end
  end

  def show
    # hämta ut användare
    @user = User.find(session[:userid])    
    # kolla att användaren är rätt
    if session[:userid].to_s === params[:id]
      render "show"
    else
      redirect_to users_path
    end
  end

  # Apinyckelsmetoder
  
  def newkey    
    @user = User.find_by_id(session[:userid])
    @user.apikey = SecureRandom.hex
    if @user.update_attribute(:apikey,SecureRandom.hex)
      flash[:notice] = "En ny nyckel genererades"
    else
      flash[:notice] = "Fel uppstod"
    end       
    redirect_to @user
  end
  
  def remkey
    @user = User.find_by_id(session[:userid])
    
    if @user.update_attribute(:apikey,nil)
      flash[:notice] = "Nyckeln togs bort"
    else
      flash[:notice] = "Fel uppstod"
    end
    redirect_to @user
  end
  
  # Inloggningsmetoder
  
  def login
    u = User.find_by_email(params[:email])
    if u && u.authenticate(params[:password])
      session[:userid] = u.id
      redirect_to u
    else
      flash[:notice] = "Inloggningen misslyckades"
      redirect_to users_path
    end
  end
  
  
  def logout
    session[:userid] = nil
    redirect_to users_path, notice: "Du loggades ut"
  end
  
  private
  
  # parametrar som tillåts då ny användare skapas
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end  
end
