class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id

      t.timestamps
    end
  end
end
