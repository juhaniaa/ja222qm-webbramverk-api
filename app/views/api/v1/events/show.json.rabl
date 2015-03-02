object @event
attributes :id, :description, :created_at

child :hunter do
  attributes :name
end

child :position do
  attributes :lat, :lng
end

child :tags do
  attributes :tagName
end