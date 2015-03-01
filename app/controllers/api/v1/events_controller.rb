module Api
  module V1    
    class EventsController < ApiController # Api::BaseController
      before_filter :restrict_access
      before_action :offset_params, only: [:index]
            
      def index # latest first
        if params[:tag_id].present?
          @tag = Tag.find(params[:tag_id])
          @events = @tag.events
        elsif params[:hunter_id].present?
          @hunter = Hunter.find(params[:hunter_id])
          @events = @hunter.events
        else
          @events = Event.limit(@limit).offset(@offset).sort_by{ |a| a[:created_at] }.reverse
        end
      end               
      
      
      def show
        @event = Event.find(params[:id])
      end
      
      def nearby        
        if params[:lng].present? && params[:lat].present?

          # get all positions in range                   
          @positions = Position.within(10, :origin => [params[:lat], params[:lng]])
                  
          # get events related to positions
          @events = []
          @positions.each do |position|
            @events << position.event
          end       
          
          #render @events
          render(:file => 'api/v1/events/index.json.rabl')
          
        else
          error = ErrorMessage.new("Could not find any resources. Bad parameters?", "Could not find any events!" )
          render json: error, status: :bad_request
        end
      end
      
      def query     
        query_param = '%' + params[:query] + '%'
        @events = Event.where('description like ?', query_param).limit(@limit).offset(@offset)                
        render(:file => 'api/v1/events/index.json.rabl')
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
    class ErrorMessage
      def initialize(dev_mess, usr_mess)
      # This is going to be json...camelcase
      @developerMessage = dev_mess
      @userMessage = usr_mess
     end
    end
  end
end