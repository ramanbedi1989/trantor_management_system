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

ActiveRecord::Schema.define(version: 20140925103545) do

  create_table "attendances", force: true do |t|
    t.integer  "user_id"
    t.date     "attendance_date"
    t.boolean  "present"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comp_off_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "days"
    t.text     "reason"
    t.boolean  "approved",      default: false
    t.boolean  "rejected",      default: false
    t.date     "applied_date"
    t.date     "approved_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confirmations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emp_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genders", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.boolean  "day_shift"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_credits", force: true do |t|
    t.integer  "user_id"
    t.integer  "leave_id"
    t.integer  "attendance_id"
    t.integer  "leave_info_id"
    t.date     "leave_credited_date"
    t.boolean  "consumed",            default: false
    t.boolean  "half_day_leave",      default: false
    t.boolean  "is_first_half"
    t.integer  "other_half_leave_id"
    t.integer  "comp_off_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_infos", force: true do |t|
    t.integer  "user_id"
    t.date     "date_from"
    t.date     "date_to"
    t.string   "reason"
    t.date     "leave_applied_date"
    t.date     "leave_approved_date"
    t.boolean  "approved",            default: false
    t.boolean  "rejected",            default: false
    t.boolean  "cancelled",           default: false
    t.boolean  "cancel_request",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaves", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loss_of_pay_infos", force: true do |t|
    t.integer  "loss_of_pay_id"
    t.integer  "attendance_id"
    t.integer  "leave_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loss_of_pays", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lta_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marital_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "med_reimb_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",                            null: false
    t.string   "ecode"
    t.string   "name"
    t.integer  "emp_type_id"
    t.integer  "designation_id"
    t.integer  "grade_id"
    t.datetime "date_of_joining"
    t.integer  "manager_id"
    t.integer  "project_id"
    t.string   "bu"
    t.string   "total_exp"
    t.string   "trantor_exp"
    t.string   "prior_exp"
    t.string   "email"
    t.integer  "confirmation_id"
    t.integer  "status_id"
    t.integer  "location_id"
    t.string   "current_contact"
    t.string   "emergency_contact_no"
    t.datetime "date_of_birth"
    t.integer  "gender_id"
    t.string   "blood_group"
    t.string   "marital_status_id"
    t.datetime "marriage_anniv_date"
    t.string   "pan"
    t.string   "bank_name"
    t.string   "bank_ac_no"
    t.string   "ifsc"
    t.string   "bank_address"
    t.integer  "lta_option_id"
    t.integer  "med_reimb_option_id"
    t.string   "pf_no"
    t.string   "esi_no"
    t.integer  "card_no"
    t.boolean  "day_shift"
    t.boolean  "active",               default: true
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
