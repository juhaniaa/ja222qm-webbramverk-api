class Api::V1::AuthController < ApiController 
  
  # Authenticate Hunter  
  
  def api_auth    
    @hunter = Hunter.find_by(email: params[:email])
    if @hunter && @hunter.authenticate(params[:password])      
      render json: { auth_token: encodeJWT(@hunter) }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end    
  end
end
