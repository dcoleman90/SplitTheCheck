class DeleteDownVotesColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :restaurants, :up_votes
  end
end
