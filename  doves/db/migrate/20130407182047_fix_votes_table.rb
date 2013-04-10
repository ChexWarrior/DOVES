class FixVotesTable < ActiveRecord::Migration
  def change
	rename_column(:votes, :User_id, :user_id)
	rename_column(:votes, :Submission_id, :submission_id)
  end
end
