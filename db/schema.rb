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

ActiveRecord::Schema.define(version: 20150225074829) do

  create_table "events", force: :cascade do |t|
    t.integer  "github_id",  limit: 8,   null: false
    t.string   "event_type", limit: 255
    t.integer  "repo_id",    limit: 4
    t.integer  "org_id",     limit: 4
    t.boolean  "public",     limit: 1
    t.datetime "event_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "events", ["event_at"], name: "index_events_on_event_at", using: :btree
  add_index "events", ["event_type"], name: "index_events_on_event_type", using: :btree
  add_index "events", ["github_id"], name: "index_events_on_github_id", unique: true, using: :btree
  add_index "events", ["org_id"], name: "index_events_on_org_id", using: :btree
  add_index "events", ["public"], name: "index_events_on_public", using: :btree
  add_index "events", ["repo_id"], name: "index_events_on_repo_id", using: :btree

  create_table "measure_counts", force: :cascade do |t|
    t.integer  "user_id",       limit: 4,   null: false
    t.string   "metric_name",   limit: 255, null: false
    t.string   "period_name",   limit: 255, null: false
    t.integer  "measure_value", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "measure_counts", ["metric_name"], name: "index_measure_counts_on_metric_name", using: :btree
  add_index "measure_counts", ["period_name"], name: "index_measure_counts_on_period_name", using: :btree
  add_index "measure_counts", ["user_id", "metric_name", "period_name"], name: "index_measure_counts_on_user_id_and_metric_name_and_period_name", unique: true, using: :btree
  add_index "measure_counts", ["user_id"], name: "index_measure_counts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",   limit: 255, null: false
    t.integer  "github_id",  limit: 4,   null: false
    t.string   "user_type",  limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "users", ["github_id"], name: "index_users_on_github_id", using: :btree
  add_index "users", ["username", "github_id"], name: "index_users_on_username_and_github_id", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
