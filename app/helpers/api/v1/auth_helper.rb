module Api::V1::AuthHelper
  ### API auth JWT   
  
  # This is a callback which actions will call if protected
  def api_authenticate 
    if request.headers["Authorization"].present?
      # Take the last part in The header (ignore Bearer)
      auth_header = request.headers['Authorization'].split(' ').last
      # Are we feeling alright!?
      @token_payload = decodeJWT auth_header.strip
      if !@token_payload
        render json: { error: 'The provided token wasn´t correct' }, status: :bad_request 
      end
    else
      render json: { error: 'Need to include the Authorization header' }, status: :forbidden # The header isn´t present
    end
  end
  
  # This method is for encoding the JWT before sending it out
  def encodeJWT(user, exp=2.hours.from_now)
    # add the expire to the payload, as an integer
    payload = { user_id: user.id }
    payload[:exp] = exp.to_i
    
    # Encode the payload with the application secret, and a more advanced hash method (creates header with JWT gem)
    JWT.encode( payload, Rails.application.secrets.secret_key_base, "HS512")
    
  end
  
  # When we get a call we have to decode it - Returns the payload if good otherwise false
  def decodeJWT(token)
   # puts token
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, "HS512")
   # puts payload
    if payload[0]["exp"] >= Time.now.to_i
      payload
    else
      puts "time error"
      false
    end
    # catch the error if token is wrong
    rescue => error
      puts error
      nil
  end
end
