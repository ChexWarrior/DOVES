class FixMultimedia < ActiveRecord::Migration
  def up
	rename_column :multimedia, :Submission_id, :submission_id
	remove_column :multimedia, :type, :time, :size
  end

  def down
  end
end
