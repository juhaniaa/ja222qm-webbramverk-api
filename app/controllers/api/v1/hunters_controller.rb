class Api::V1::HuntersController < ApiController
  before_filter :restrict_access
      
  def index
    @hunters = Hunter.all
  end


  def create
    # create hunter with post params
    @hunter = Hunter.new(hunter_params)

    if @hunter.save
      render(:file => 'api/v1/hunters/show.json.rabl')
    else
      render json: {error: "Could not create the resource"}, status: :bad_request
    end
  end


  private

  def hunter_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      puts token
      Apikey.exists?(key: token)
    end
  end 
end
