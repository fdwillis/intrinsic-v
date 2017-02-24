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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170214024551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logs", force: :cascade do |t|
    t.integer  "price",        default: 0
    t.integer  "equity",       default: 0
    t.integer  "shares",       default: 0
    t.integer  "net_income",   default: 0
    t.integer  "month"
    t.integer  "day"
    t.integer  "bv"
    t.integer  "year"
    t.integer  "quarter_year"
    t.string   "quarter"
    t.float    "coupon",       default: 0.0
    t.integer  "stock_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "logs", ["stock_id"], name: "index_logs_on_stock_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.string   "symbol"
    t.float    "old_bv",     default: 0.0
    t.float    "bv_years",   default: 0.0
    t.boolean  "admin_only"
    t.boolean  "admin_fav"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "logs", "stocks"
end
