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

ActiveRecord::Schema.define(version: 20170224201906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.date     "start_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.date     "end_date"
    t.integer  "status",          default: 0
    t.date     "actual_end_date"
    t.integer  "client_id"
    t.text     "description"
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.date     "estimated_start_date"
    t.integer  "project_id"
    t.decimal  "duration",             default: "0.0"
    t.string   "name"
    t.integer  "status",               default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.date     "estimated_end_date"
    t.date     "actual_start_date"
    t.decimal  "actual_duration",      default: "0.0"
    t.text     "description"
    t.datetime "time_tracker"
    t.index ["project_id"], name: "index_tasks_on_project_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.decimal  "availability",           default: "0.0"
    t.string   "type"
    t.integer  "project_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "projects", "users"
  add_foreign_key "tasks", "projects"
end
