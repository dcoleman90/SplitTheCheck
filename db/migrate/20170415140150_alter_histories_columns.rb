class AlterHistoriesColumns < ActiveRecord::Migration[5.0]
  def up
  	change_column_null :histories, :restaurant_id, false
  	change_column_null :histories, :user_id,  false
  	remove_index :histories, :restaurant_id
  	remove_index :histories, :user_id
  end
end
