class UpdateBirdsTable < ActiveRecord::Migration
  def up
	add_column :birds, :position, :integer
	add_column :birds, :region, :text
	Bird.connection.execute("update birds set position=id")
  end
end
