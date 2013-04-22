class AddSalt < ActiveRecord::Migration
  def up
	change_table :users do |t|
		t.string :salt
	end
  end

  def down
	
  end
end
