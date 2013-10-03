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

ActiveRecord::Schema.define(version: 20131003150309) do

  create_table "addresses", force: true do |t|
    t.string   "street"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "earring_id"
    t.boolean  "buy"
  end

  create_table "counties", force: true do |t|
    t.integer  "state_id"
    t.string   "abbr"
    t.string   "name"
    t.string   "county_seat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "counties", ["name"], name: "index_counties_on_name"
  add_index "counties", ["state_id"], name: "index_counties_on_state_id"

  create_table "earrings", force: true do |t|
    t.string   "vendor"
    t.string   "collection"
    t.string   "design"
    t.string   "material"
    t.integer  "size"
    t.integer  "price"
    t.string   "sku"
    t.integer  "inventory"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "earring_id"
    t.integer  "price_paid"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
  end

  create_table "states", force: true do |t|
    t.string   "abbr",       limit: 2
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["abbr"], name: "index_states_on_abbr"

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "zipcodes", force: true do |t|
    t.string   "code"
    t.string   "city"
    t.integer  "state_id"
    t.integer  "county_id"
    t.string   "area_code"
    t.decimal  "lat",        precision: 15, scale: 10
    t.decimal  "lon",        precision: 15, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zipcodes", ["code"], name: "index_zipcodes_on_code"
  add_index "zipcodes", ["county_id"], name: "index_zipcodes_on_county_id"
  add_index "zipcodes", ["lat", "lon"], name: "index_zipcodes_on_lat_and_lon"
  add_index "zipcodes", ["state_id"], name: "index_zipcodes_on_state_id"

end
