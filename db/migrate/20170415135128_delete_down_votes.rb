class DeleteDownVotes < ActiveRecord::Migration[5.0]
  def change
      remove_column :restaurants, :down_votes
  end
end
