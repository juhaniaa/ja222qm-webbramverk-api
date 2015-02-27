class CreateEventsTagsJoinTable < ActiveRecord::Migration
  def change     
    create_table :events_tags, id: false do |t|
      t.integer :event_id
      t.integer :tag_id
    end  
  end
end
