class ChangeApikeyAsocciationName < ActiveRecord::Migration
  def change
    change_table :apikeys do |t|
      t.rename :userid, :user_id    
    end
  end
end
