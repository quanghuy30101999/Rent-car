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

ActiveRecord::Schema.define(version: 20200409152524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "name"
    t.string "year"
    t.string "color"
    t.integer "price"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "available"
    t.string "price_unit", default: "VND"
    t.datetime "begin"
    t.datetime "end"
    t.index ["user_id", "created_at"], name: "index_cars_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "extension_orders", force: :cascade do |t|
    t.bigint "order_id"
    t.datetime "return_time"
    t.string "status", default: "requesting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "rent_time"
    t.index ["order_id", "created_at"], name: "index_extension_orders_on_order_id_and_created_at"
    t.index ["order_id"], name: "index_extension_orders_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "return_time"
    t.datetime "real_return_time"
    t.bigint "user_id"
    t.bigint "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "rent_time"
    t.string "status", default: "requesting"
    t.integer "phone"
    t.datetime "request_date"
    t.index ["car_id"], name: "index_orders_on_car_id"
    t.index ["user_id", "created_at"], name: "index_orders_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.boolean "admin", default: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.integer "phone"
    t.boolean "gender"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "cars", "users"
  add_foreign_key "extension_orders", "orders"
  add_foreign_key "orders", "cars"
  add_foreign_key "orders", "users"
end
