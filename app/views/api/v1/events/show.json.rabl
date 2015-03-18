object @event
attributes :id, :description, :created_at

node :meta do |event|
   {:href => api_event_path(event)}
end

child :hunter do |h|
  attributes :name
  node :meta do
    {:href => api_hunter_path(h)}
  end
end

child :position do |p|
  attributes :lat, :lng
end

child :tags do
  attributes :name
end

