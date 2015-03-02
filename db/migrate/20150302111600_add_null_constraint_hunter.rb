class AddNullConstraintHunter < ActiveRecord::Migration
  def change
    change_column_null :hunters, :email, false
    change_column_null :hunters, :password_digest, false    
  end
end
