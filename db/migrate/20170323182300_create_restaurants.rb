class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :up_votes, :default => 0
      t.integer :down_votes, :default => 0

      t.timestamps
    end
  end
end
