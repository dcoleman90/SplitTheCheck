class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.belongs_to :restaurant, index: true, foreign_key: true
      t.belongs_to :user, 		index: true, foreign_key: true
      t.integer :up_votes_added, 	default: 0
      t.integer :down_votes_added, 	default: 0
      t.integer :up_votes_total, 	default: 0
      t.integer :down_votes_total, 	default: 0

      t.timestamps
    end
  end
end
