class Api::V1::AuthController < ApiController 
  
  # Authenticate Hunter  
  
  def api_auth # sets a jwt token if correct params are sent for a hunter
    @hunter = Hunter.find_by(email: params[:email])
    if @hunter && @hunter.authenticate(params[:password])      
      render json: { auth_token: encodeJWT(@hunter), hunter_name: @hunter.name, hunter_id: @hunter.id }
    else      
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end    
  end
end
