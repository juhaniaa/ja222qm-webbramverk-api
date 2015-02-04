class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.decimal "longitude", {:precision => 10, :scale => 6}
      t.decimal "latitude", {:precision => 10, :scale => 6}
      t.timestamps
    end
  end
end
