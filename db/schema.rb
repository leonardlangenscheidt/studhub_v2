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

ActiveRecord::Schema.define(version: 20131125214353) do

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
    t.boolean  "right"
    t.boolean  "used"
    t.integer  "order_id"
  end

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
    t.boolean  "sides"
    t.boolean  "easyRestock"
    t.integer  "used_inventory"
  end

  create_table "identities", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "earring_id"
    t.integer  "price_paid"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
    t.string   "tracking"
    t.integer  "number"
    t.integer  "tax"
  end

  create_table "users", force: true do |t|
    t.string "email"
    t.string "name"
  end

end
