class ChangeTagName < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.rename :tagName, :name
    end
  end
end
