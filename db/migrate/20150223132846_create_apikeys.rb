class CreateApikeys < ActiveRecord::Migration
  def change
    create_table :apikeys do |t|
      t.string   "key"
      t.integer  "userid"
      t.timestamps
    end
  end
end
