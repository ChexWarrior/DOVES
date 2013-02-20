class CreateMultimedia < ActiveRecord::Migration
  def change
    create_table :multimedia do |t|
      t.integer :Submission_id
      t.string :type
      t.datetime :time
      t.integer :size

      t.timestamps
    end
  end
end
