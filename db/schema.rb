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

ActiveRecord::Schema.define(version: 20150519065212) do

  create_table "attendances", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.date     "attendance_date"
    t.boolean  "present",         limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comp_off_requests", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "days",          limit: 4
    t.text     "reason",        limit: 65535
    t.boolean  "approved",      limit: 1,     default: false
    t.boolean  "rejected",      limit: 1,     default: false
    t.date     "applied_date"
    t.date     "approved_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confirmations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emp_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genders", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.date     "date"
    t.boolean  "day_shift",  limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_credits", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.integer  "leave_id",            limit: 4
    t.integer  "attendance_id",       limit: 4
    t.integer  "leave_info_id",       limit: 4
    t.date     "leave_credited_date"
    t.boolean  "consumed",            limit: 1, default: false
    t.boolean  "half_day_leave",      limit: 1, default: false
    t.boolean  "is_first_half",       limit: 1
    t.integer  "other_half_leave_id", limit: 4
    t.integer  "comp_off_request_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_infos", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.date     "date_from"
    t.date     "date_to"
    t.string   "reason",              limit: 255
    t.date     "leave_applied_date"
    t.date     "leave_approved_date"
    t.boolean  "approved",            limit: 1,   default: false
    t.boolean  "rejected",            limit: 1,   default: false
    t.boolean  "cancelled",           limit: 1,   default: false
    t.boolean  "cancel_request",      limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaves", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loss_of_pay_infos", force: :cascade do |t|
    t.integer  "loss_of_pay_id", limit: 4
    t.integer  "attendance_id",  limit: 4
    t.integer  "leave_info_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loss_of_pays", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lta_options", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marital_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_reimb_options", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_users", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",             limit: 255,                null: false
    t.string   "ecode",                limit: 255
    t.string   "name",                 limit: 255
    t.integer  "emp_type_id",          limit: 4
    t.integer  "designation_id",       limit: 4
    t.integer  "grade_id",             limit: 4
    t.datetime "date_of_joining"
    t.integer  "manager_id",           limit: 4
    t.string   "bu",                   limit: 255
    t.string   "total_exp",            limit: 255
    t.string   "trantor_exp",          limit: 255
    t.string   "prior_exp",            limit: 255
    t.string   "email",                limit: 255
    t.integer  "confirmation_id",      limit: 4
    t.integer  "status_id",            limit: 4
    t.integer  "location_id",          limit: 4
    t.string   "current_contact",      limit: 255
    t.string   "emergency_contact_no", limit: 255
    t.datetime "date_of_birth"
    t.integer  "gender_id",            limit: 4
    t.string   "blood_group",          limit: 255
    t.string   "marital_status_id",    limit: 255
    t.datetime "marriage_anniv_date"
    t.string   "pan",                  limit: 255
    t.string   "bank_name",            limit: 255
    t.string   "bank_ac_no",           limit: 255
    t.string   "ifsc",                 limit: 255
    t.string   "bank_address",         limit: 255
    t.integer  "lta_option_id",        limit: 4
    t.string   "contractual_ecode",    limit: 255
    t.string   "pf_no",                limit: 255
    t.string   "esi_no",               limit: 255
    t.integer  "card_no",              limit: 4
    t.boolean  "day_shift",            limit: 1
    t.boolean  "active",               limit: 1,   default: true
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",   limit: 255
    t.string   "last_sign_in_ip",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                 limit: 255
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
