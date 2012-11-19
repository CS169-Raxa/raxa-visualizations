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

ActiveRecord::Schema.define(:version => 20121119012755) do

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "drug_delta", :force => true do |t|
    t.datetime "timestamp"
    t.float    "amount"
    t.string   "description"
    t.integer  "drug_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "drug_delta", ["drug_id"], :name => "index_drug_delta_on_drug_id"

  create_table "drugs", :force => true do |t|
    t.string   "name"
    t.float    "quantity"
    t.float    "estimated_rate"
    t.float    "user_rate"
    t.float    "alert_level"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "units"
  end

  create_table "encounters", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "department_id"
    t.integer  "patient_id"
  end

  create_table "patients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrars", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrations", :force => true do |t|
    t.datetime "time_start"
    t.datetime "time_end"
    t.string   "patient_status", :default => "new"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "patient_id"
    t.integer  "registrar_id"
  end

end
