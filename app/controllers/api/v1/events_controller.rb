module Api
  module V1
    class EventsController < ApplicationController # Api::BaseController
      before_filter :restrict_access
            
      def index # latest first
        if params[:tag_id].present?
          @tag = Tag.find(params[:tag_id])
          @events = @tag.events
        elsif params[:hunter_id].present?
          @hunter = Hunter.find(params[:hunter_id])
          @events = @hunter.events
        else
          @events = Event.all.sort_by{ |a| a[:created_at] }.reverse
        end
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