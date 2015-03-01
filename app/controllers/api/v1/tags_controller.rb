class Api::V1::TagsController < ApplicationController
  before_filter :restrict_access
      
  def index
    @tags = Tag.all
  end


  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      Apikey.exists?(key: token)
    end
  end 
end
