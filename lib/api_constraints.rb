class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end
  
  def matches?(req)
    @default || req.headers['Accept'].include?('application/vnd.trophy.v#{@version}')
  end
end

# Curl example request
# 'Accept: application/vnd.trophy.v1' http://localhost:3000/api/events
