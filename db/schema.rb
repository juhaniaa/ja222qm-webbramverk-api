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

ActiveRecord::Schema.define(version: 20150318102607) do

  create_table "admins", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apikeys", force: true do |t|
    t.string   "key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hunter_id"
  end

  create_table "events_tags", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "tag_id"
  end

  create_table "hunters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",           null: false
    t.string   "password_digest", null: false
  end

  create_table "positions", force: true do |t|
    t.decimal  "lng",        precision: 10, scale: 6
    t.decimal  "lat",        precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "description"
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
