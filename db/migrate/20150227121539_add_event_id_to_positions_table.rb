class AddEventIdToPositionsTable < ActiveRecord::Migration
  def change
    change_table :positions do |t|
      t.integer :event_id    
    end
  end
end
