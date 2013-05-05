class AddStatusToVotes < ActiveRecord::Migration
  def change
	 change_table :votes do |t|
      t.boolean :cast_vote, :default => true
    end
  end
end
