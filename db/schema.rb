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

ActiveRecord::Schema.define(version: 20140422062725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "dogs", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dogs", ["owner_id"], name: "index_dogs_on_owner_id", using: :btree

  create_table "dogs_sittings", id: false, force: :cascade do |t|
    t.integer "sitting_id", null: false
    t.integer "dog_id",     null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "sitting_id"
    t.text     "review_text"
    t.integer  "review_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["sitting_id"], name: "index_reviews_on_sitting_id", using: :btree

  create_table "sittings", force: :cascade do |t|
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "sitter_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sittings", ["owner_id"], name: "index_sittings_on_owner_id", using: :btree
  add_index "sittings", ["sitter_id"], name: "index_sittings_on_sitter_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "image_url"
    t.boolean  "is_owner",           default: false
    t.boolean  "is_sitter",          default: false
    t.float    "sitter_score",       default: 0.0
    t.float    "ratings_score",      default: 0.0
    t.float    "sitter_rank",        default: 0.0
    t.float    "review_ratings_sum", default: 0.0
    t.integer  "num_sitter_stays",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["sitter_rank"], name: "index_users_on_sitter_rank", using: :btree

  add_foreign_key "dogs", "users", column: "owner_id"
  add_foreign_key "sittings", "users", column: "owner_id"
  add_foreign_key "sittings", "users", column: "sitter_id"
end
