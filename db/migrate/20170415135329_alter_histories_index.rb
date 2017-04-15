class AlterHistoriesIndex < ActiveRecord::Migration[5.0]
  def change
  	add_index :histories, [:restaurant_id, :user_id], unique: true
  end
end
