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

ActiveRecord::Schema.define(:version => 20110706064254) do

  create_table "checkins", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "room_id"
    t.datetime "check_in"
    t.datetime "check_out"
    t.float    "no_of_hrs"
    t.integer  "user_id"
    t.float    "amount_charged"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "contact_no"
    t.string   "state_id_card"
    t.string   "driving_license"
    t.string   "emergency_contact_name"
    t.string   "emergency_contact_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.integer  "number"
    t.string   "description"
    t.integer  "charges_per_hr"
    t.integer  "key_no"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_logs", :force => true do |t|
    t.integer  "user_id"
    t.datetime "login_time"
    t.datetime "logout_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.integer  "failed_login_count"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "time_zone"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",              :default => false
    t.string   "perishable_token"
    t.boolean  "active",             :default => true
    t.string   "contactno"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
