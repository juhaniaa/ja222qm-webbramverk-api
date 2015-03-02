module Api
  module V1    
    class EventsController < ApiController # Api::BaseController
      before_filter :restrict_access # make sure valid client access_token is present
      before_action :offset_params, only: [:index] # check offset and limit params
      before_action :api_authenticate, only: [:create] # authenticate hunter to modify information
            
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
        
        # { "event":
        #  {
        #    "description": "I am sooo happy",  
        #    "position_attributes":
        #      {
        #        "lat": 60.207225,
        #        "lng": 20.269015
        #      }
        #    "tags": 
        #      [
        #        { tagName: "Cool"},
        #        { tagName: "Wooow"},
        #        { tagName: "Nice"}
        #      ]
        #   }
        # } 
        
        post_attributes = event_params
        event_p = post_attributes.delete("description")
        position_p = post_attributes.delete("position_attributes")
        tags_p = post_attributes
        
        # create event
        @event = Event.new(description: event_p)
        
        # create and add position
        @position = Position.create(position_p)        
        @event.position = @position                        
        
        # for each tag in params
        tags_p[:tags].each do |t| 
          ## chekc if exists else create it
          
          
          # add all tags to event 
          @event.tags << Tag.create(t)       
        end        
        
        # add event to Hunter
        hunter = Hunter.find(@token_payload[0]["hunter_id"])
        hunter.events << @event        

        # save and render result
        if @event.save
          render(:file => 'api/v1/events/show.json.rabl')
        else
          error = ErrorMessage.new("Could not create the resource. Bad parameters?", "Could not create the resource!" )
          render json: error, status: :bad_request
        end
      end      
      
      private            
      
      def event_params
        json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
        json_params.require(:event).permit(:description, position_attributes: [:lat, :lng], :tags => [:tagName])
      end
      
      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          Apikey.exists?(key: token)
        end
      end      
    end
    
    class ErrorMessage
      def initialize(dev_mess, usr_mess)
      
      @developerMessage = dev_mess
      @userMessage = usr_mess
     end
    end
    
  end
end