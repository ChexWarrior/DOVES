class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :User_id
      t.integer :Submission_id
      t.integer :round
      t.string :vote
      t.text :comments
      t.datetime :time

      t.timestamps
    end
  end
end
