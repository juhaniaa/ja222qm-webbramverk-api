class ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  
  # default parameters
  OFFSET = 0
  LIMIT = 20

  # check offset/limit
  def offset_params
    if params[:offset].present?
      @offset = params[:offset].to_i
    end
    if params[:limit].present?
      @limit = params[:limit].to_i
    end
    @offset ||= OFFSET
    @limit  ||= LIMIT
  end
  
end