class CreateBirds < ActiveRecord::Migration
  def change
    create_table :birds do |t|
      t.string :common_name
      t.string :reviewable

      t.timestamps
    end
  end
end
