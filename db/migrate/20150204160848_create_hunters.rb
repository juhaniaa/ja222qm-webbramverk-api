class CreateHunters < ActiveRecord::Migration
  def change
    create_table :hunters do |t|
      t.string "name"  
      t.timestamps
    end
  end
end
