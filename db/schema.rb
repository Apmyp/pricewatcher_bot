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

ActiveRecord::Schema.define(version: 2020_04_08_063532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "link_items", force: :cascade do |t|
    t.bigint "link_id", null: false
    t.string "name"
    t.string "image"
    t.decimal "price", precision: 10, scale: 2
    t.string "currency"
    t.boolean "availability", default: false, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["link_id"], name: "index_link_items_on_link_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "link"
    t.string "hash_id"
    t.string "scheme"
    t.string "host"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "telegram_user_id", null: false
    t.string "path"
    t.integer "errors_count", default: 0, null: false
    t.index ["telegram_user_id", "link"], name: "index_links_on_telegram_user_id_and_link", unique: true
    t.index ["telegram_user_id"], name: "index_links_on_telegram_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "html"
    t.bigint "link_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["link_id"], name: "index_requests_on_link_id"
  end

  create_table "telegram_users", force: :cascade do |t|
    t.integer "external_id"
    t.string "first_name"
    t.string "username"
    t.string "language_code"
    t.jsonb "raw_data"
    t.integer "status", default: 0, null: false
    t.boolean "subscribed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active_links_count", default: 0, null: false
    t.integer "links_count", default: 0, null: false
    t.index ["external_id"], name: "index_telegram_users_on_external_id"
  end

  add_foreign_key "link_items", "links"
  add_foreign_key "links", "telegram_users"
  add_foreign_key "requests", "links"
end
