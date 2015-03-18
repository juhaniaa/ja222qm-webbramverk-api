module Api
  module V1    
    class EventsController < ApiController # Api::BaseController
      before_filter :restrict_access # make sure valid client access_token is present
      before_action :offset_params, only: [:index] # check offset and limit params
      before_action :api_authenticate, only: [:create, :update, :destroy] # authenticate hunter to modify information

      def index # latest first
        if params[:tag_id].present?
          @tag = Tag.find(params[:tag_id])
          @events = @tag.events.limit(@limit).offset(@offset).sort_by{ |a| a[:created_at] }.reverse
        elsif params[:hunter_id].present?
          @hunter = Hunter.find(params[:hunter_id])
          @events = @hunter.events.limit(@limit).offset(@offset).sort_by{ |a| a[:created_at] }.reverse
        else
          @events = Event.limit(@limit).offset(@offset).sort_by{ |a| a[:created_at] }.reverse
        end
      end                     
      
      def show
        @event = Event.find_by_id(params[:id])
        unless @event
          error = ErrorMessage.new("Could not find the resource. Does it exist?", "Could not find the resource!" )
          render json: error, status: :bad_request
        end
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
        #        { name: "Cool"},
        #        { name: "Wooow"},
        #        { name: "Nice"}
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
          tag = Tag.find_by(t)
          if tag # check if exists
            @event.tags << tag
          else # else create it             
            @event.tags << Tag.create(t)       
          end                    
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
      
      def update # events/:id                           
        # check if hunter is owner of chosen event
        hunter = Hunter.find(@token_payload[0]["hunter_id"])
        if hunter.events.find_by_id(params[:id])        
          update_params = event_params[:description]

          @event = Event.find(params[:id])
          if @event.update(description: update_params)
            render(:file => 'api/v1/events/show.json.rabl')
          else
            error = ErrorMessage.new("Could not update the resource. Bad parameters?", "Could not update the resource!" )
            render json: error, status: :bad_request
          end
        else
          error = ErrorMessage.new("Could not update the resource. Hunter does not have access!", "Could not update the resource!" )
          render json: error, status: :unauthorized
        end       
      end
      
      def destroy
        # check if hunter is owner of chosen event
        hunter = Hunter.find(@token_payload[0]["hunter_id"])
        if hunter.events.find_by_id(params[:id])            

          @event = Event.find(params[:id])
          if @event.destroy
            render json: { poof: "gone" }
          else
            error = ErrorMessage.new("Could not remove the resource. Bad parameters?", "Could not remove the resource!" )
            render json: error, status: :bad_request
          end
        else
          error = ErrorMessage.new("Could not remove the resource. Either resource does not exist or Hunter does not have access!", "Could not remove the resource!" )
          render json: error, status: :unauthorized
        end   
      end
      
      private            
      
      def event_params
        json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
        json_params.require(:event).permit(:description, position_attributes: [:lat, :lng], :tags => [:name])
      end
      
      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          puts token
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