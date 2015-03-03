object @hunter
attributes :id, :name

node :meta do |hunter|
   {:href => api_hunter_path(hunter)}
end

child :events do |e|
  extends 'api/v1/events/show'
end
