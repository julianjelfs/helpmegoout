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

ActiveRecord::Schema.define(:version => 20130516191516) do

  create_table "candidates", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "candidates", ["email"], :name => "index_candidates_on_email"

  create_table "candidates_circles", :id => false, :force => true do |t|
    t.integer "candidate_id"
    t.integer "circle_id"
  end

  add_index "candidates_circles", ["candidate_id"], :name => "index_candidates_circles_on_candidate_id"
  add_index "candidates_circles", ["circle_id"], :name => "index_candidates_circles_on_circle_id"

  create_table "children", :force => true do |t|
    t.string   "name"
    t.date     "dob"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "circles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "owner_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "circles", ["owner_id"], :name => "index_circles_on_owner_id"

  create_table "circles_requests", :id => false, :force => true do |t|
    t.integer "circle_id"
    t.integer "request_id"
  end

  add_index "circles_requests", ["circle_id"], :name => "index_circles_requests_on_circle_id"
  add_index "circles_requests", ["request_id"], :name => "index_circles_requests_on_request_id"

  create_table "circles_users", :id => false, :force => true do |t|
    t.integer "circle_id"
    t.integer "user_id"
  end

  add_index "circles_users", ["circle_id"], :name => "index_circles_users_on_circle_id"
  add_index "circles_users", ["user_id"], :name => "index_circles_users_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "requests", :force => true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "description"
    t.integer  "volunteer_id"
    t.integer  "priority"
  end

  add_index "requests", ["user_id"], :name => "index_requests_on_user_id"
  add_index "requests", ["volunteer_id"], :name => "index_requests_on_volunteer_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "score"
    t.string   "name"
    t.text     "address"
    t.string   "phone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
