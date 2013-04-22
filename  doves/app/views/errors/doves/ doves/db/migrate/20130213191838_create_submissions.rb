class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :s_degree
      t.datetime :sub_date_time
      t.integer :User_id
      t.string :sub_fname
      t.string :sub_lname
      t.integer :species
      t.string :common_name
      t.integer :num_of_birds
      t.string :age
      t.string :sex
      t.text :plumage
      t.string :location
      t.string :region
      t.datetime :sight_date_time
      t.string :habitat
      t.string :gps
      t.text :coobservers
      t.string :length_of_obs
      t.string :distance_from
      t.text :detailed_description
      t.text :detailed_behavior
      t.text :distinguished_char
      t.text :prev_bird_exp
      t.string :optical_equipment
      t.string :references
      t.integer :sub_recall
      t.string :guide_use
      t.string :unusual
      t.text :notes
      t.string :media
      t.string :status
      t.integer :rounds
      t.datetime :date_accepted
      t.datetime :date_votable
      t.text :admin_notes
      t.text :working_notes

      t.timestamps
    end
  end
end
