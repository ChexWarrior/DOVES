class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.text :prev_exp
      t.string :level

      t.timestamps
    end
  end
end
