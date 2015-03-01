class ChangeColumnNamesPositionsTable < ActiveRecord::Migration
  def change
    change_table :positions do |t|
      t.rename :longitude, :lng    
      t.rename :latitude, :lat
    end
  end
end
