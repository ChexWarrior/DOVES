class FixUserIdField < ActiveRecord::Migration
  def up
	rename_column(:submissions, :User_id, :user_id)
  end

  def down
  end
end
