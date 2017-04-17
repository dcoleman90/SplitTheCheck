class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :restaurant, foreign_key: true
      t.belongs_to :user, 		foreign_key: true
      t.string :comment, 		default: ""

      t.timestamps
    end
  end
end
