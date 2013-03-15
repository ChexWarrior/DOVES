# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130315173004) do

  create_table "birds", :force => true do |t|
    t.string   "common_name"
    t.string   "reviewable"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "multimedia", :force => true do |t|
    t.integer  "Submission_id"
    t.string   "type"
    t.datetime "time"
    t.integer  "size"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "submissions", :force => true do |t|
    t.string   "s_degree"
    t.datetime "created_on"
    t.integer  "User_id"
    t.string   "sub_fname"
    t.string   "sub_lname"
    t.integer  "bird_id"
    t.string   "common_name"
    t.integer  "num_of_birds"
    t.string   "age"
    t.string   "sex"
    t.text     "plumage"
    t.string   "location"
    t.string   "region"
    t.datetime "sight_date_time"
    t.string   "habitat"
    t.string   "gps"
    t.text     "coobservers"
    t.string   "length_of_obs"
    t.string   "distance_from"
    t.text     "detailed_description"
    t.text     "detailed_behavior"
    t.text     "distinguished_char"
    t.text     "prev_bird_exp"
    t.string   "optical_equipment"
    t.string   "references"
    t.integer  "sub_recall"
    t.string   "guide_use"
    t.string   "unusual"
    t.text     "notes"
    t.string   "media"
    t.string   "status"
    t.integer  "rounds"
    t.datetime "date_accepted"
    t.datetime "date_votable"
    t.text     "admin_notes"
    t.text     "working_notes"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.datetime "updated_on"
  end

  create_table "users", :force => true do |t|
    t.string   "encrypted_password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.text     "prev_exp"
    t.string   "level"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "salt"
  end

  create_table "votes", :force => true do |t|
    t.integer  "User_id"
    t.integer  "Submission_id"
    t.integer  "round"
    t.string   "vote"
    t.text     "comments"
    t.datetime "time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
