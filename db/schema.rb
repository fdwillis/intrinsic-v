# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2017_02_14_024551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logs", id: :serial, force: :cascade do |t|
    t.integer "price", null: false
    t.integer "equity", null: false
    t.integer "shares", null: false
    t.integer "net_income", null: false
    t.integer "bv", null: false
    t.integer "year"
    t.string "quarter"
    t.float "coupon", null: false
    t.integer "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_logs_on_stock_id"
  end

  create_table "stocks", id: :serial, force: :cascade do |t|
    t.string "symbol"
    t.float "old_bv", null: false
    t.float "bv_years", null: false
    t.boolean "admin_only"
    t.boolean "admin_fav"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "logs", "stocks"
end
