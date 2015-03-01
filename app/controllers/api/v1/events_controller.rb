module Api
  module V1
    class EventsController < ApplicationController # Api::BaseController
      before_filter :restrict_access
      
      def index
        @events = Event.all
      end
      
      def show
        @event = Event.find(params[:id])
      end
      
      def create
      end
      
      
      private
      
      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          Apikey.exists?(key: token)
        end
      end      
    end
  end
end