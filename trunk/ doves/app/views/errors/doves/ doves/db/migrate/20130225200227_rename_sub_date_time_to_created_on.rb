class RenameSubDateTimeToCreatedOn < ActiveRecord::Migration
  def up
	  change_table :submissions do |t|
		t.datetime :updated_on
		t.rename :sub_date_time, :created_on
end
  end

  def down
  end
end
