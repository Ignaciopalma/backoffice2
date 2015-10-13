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

ActiveRecord::Schema.define(version: 20150813141424) do

  create_table "account_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "available_areas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "base_pricings", force: :cascade do |t|
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "deliveries", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "user_id"
    t.integer  "eta"
    t.decimal  "km"
    t.integer  "state_id",            default: 1
    t.integer  "pay_state_id",        default: 1
    t.integer  "sender_pay_state_id", default: 1
    t.string   "comuna_start"
    t.string   "comuna_finish"
    t.decimal  "lat_start"
    t.decimal  "long_start"
    t.decimal  "lat_finish"
    t.decimal  "long_finish"
    t.decimal  "peso_neto"
    t.decimal  "ancho"
    t.decimal  "largo"
    t.decimal  "alto"
    t.integer  "cost"
    t.string   "photo_id"
    t.string   "address_start"
    t.string   "address_finish"
    t.integer  "comission"
    t.integer  "confirmed",           default: 0
    t.datetime "pay_date"
    t.string   "destinatary_name"
    t.string   "destinatary_email"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "more_info"
    t.integer  "department_number"
    t.boolean  "both_ways",           default: false
    t.string   "location_type",       default: "casa"
    t.integer  "try",                 default: 1
    t.integer  "iva",                 default: 0
    t.integer  "vx_comission",        default: 0
  end

  add_index "deliveries", ["sender_id"], name: "index_deliveries_on_sender_id"
  add_index "deliveries", ["user_id"], name: "index_deliveries_on_user_id"

  create_table "delivery_photos", force: :cascade do |t|
    t.integer  "status"
    t.integer  "delivery_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "kg_pricings", force: :cascade do |t|
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "km_pricings", force: :cascade do |t|
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "occupations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pay_states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pricings", force: :cascade do |t|
    t.string   "percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "sender_pay_states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "senders", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "phone_number"
    t.string   "business_name"
    t.string   "razon_social"
    t.string   "rut"
    t.string   "giro"
    t.string   "address"
    t.integer  "area_id"
    t.integer  "city_id"
    t.integer  "days_after",             default: 0
    t.integer  "pay_fixed_date",         default: 0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pay_day",                default: 0
  end

  add_index "senders", ["email"], name: "index_senders_on_email", unique: true
  add_index "senders", ["reset_password_token"], name: "index_senders_on_reset_password_token", unique: true

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "api_key"
    t.string   "email"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "rut"
    t.string   "address"
    t.string   "phone"
    t.integer  "bank_id"
    t.integer  "account_type_id"
    t.string   "account_number"
    t.integer  "occupation_id"
    t.string   "occupation_detail"
    t.integer  "active",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.decimal  "lon"
    t.decimal  "lat"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
