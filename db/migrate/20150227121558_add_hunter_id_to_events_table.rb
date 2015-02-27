class AddHunterIdToEventsTable < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.integer :hunter_id  
    end    
  end
end
