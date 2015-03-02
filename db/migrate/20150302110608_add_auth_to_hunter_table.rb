class AddAuthToHunterTable < ActiveRecord::Migration
  def change
    change_table :hunters do |t|
       t.string   "email"
       t.string   "password_digest"
    end 
  end
end
