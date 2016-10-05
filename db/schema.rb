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

ActiveRecord::Schema.define(version: 20150609014114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "incidents", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "user_id"
    t.date     "date_incident"
    t.text     "description"
    t.text     "soluction"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["student_id"], name: "index_incidents_on_student_id", using: :btree
    t.index ["user_id"], name: "index_incidents_on_user_id", using: :btree
  end

  create_table "school_performaces", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "finish_date"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["student_id"], name: "index_school_performaces_on_student_id", using: :btree
    t.index ["user_id"], name: "index_school_performaces_on_user_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "responsible"
    t.string   "contact_responsible"
    t.date     "date_enrolment"
    t.string   "image"
    t.boolean  "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "admin"
    t.boolean  "status"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  end

  add_foreign_key "incidents", "students"
  add_foreign_key "incidents", "users"
  add_foreign_key "school_performaces", "students"
  add_foreign_key "school_performaces", "users"
end
