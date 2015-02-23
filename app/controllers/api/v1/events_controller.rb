module Api
  module V1
    class ProductsController < ApplicationController # Api::BaseController
      before_filter :restrict_access
      
      def index
        
      end
      
      def create
      end
      
      
      private
      
      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
      end      
    end
  end
end