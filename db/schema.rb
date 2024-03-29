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

ActiveRecord::Schema.define(:version => 20121220052038) do

  create_table "devices", :force => true do |t|
    t.string   "device_id"
    t.datetime "update_start_date"
    t.datetime "update_end_date"
    t.boolean  "need_update"
    t.boolean  "need_upload"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "probabilities", :force => true do |t|
    t.datetime "date"
    t.integer  "prize"
    t.integer  "count"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "pro_type",   :default => 0
  end

  create_table "slot_logs", :force => true do |t|
    t.integer  "device_id"
    t.integer  "db_id"
    t.integer  "db_prize"
    t.datetime "time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
