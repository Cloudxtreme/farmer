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

ActiveRecord::Schema.define(version: 20140313092608) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",     default: 0
    t.text     "search_index", default: ""
  end

  create_table "rack_mounts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location_id"
    t.integer  "position",     default: 0
    t.text     "search_index", default: ""
  end

  create_table "servers", force: true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "model"
    t.string   "ram",           default: "0"
    t.string   "hd",            default: "0"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rack_mount_id"
    t.integer  "position",      default: 0
    t.string   "category_id"
    t.string   "ip"
    t.text     "search_index",  default: ""
  end

  create_table "vms", force: true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",     default: 0
    t.string   "ip"
    t.text     "search_index", default: ""
    t.string   "ram",          default: "0"
    t.string   "hd",           default: "0"
  end

end
