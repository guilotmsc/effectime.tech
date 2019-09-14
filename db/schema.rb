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

ActiveRecord::Schema.define(version: 20190914130222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "contract_id"
    t.bigint "project_id"
    t.boolean "canceled", default: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_moment"
    t.datetime "end_moment"
    t.string "appointment_type"
    t.bigint "process_dept_id"
    t.bigint "user_id"
    t.index ["contract_id"], name: "index_appointments_on_contract_id"
    t.index ["process_dept_id"], name: "index_appointments_on_process_dept_id"
    t.index ["project_id"], name: "index_appointments_on_project_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "corporation_id"
    t.index ["corporation_id"], name: "index_areas_on_corporation_id"
  end

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.string "client"
    t.string "trading_name"
    t.date "signature_date"
    t.float "amount_ticket"
    t.integer "hours_volume"
    t.string "attribuition_model"
    t.integer "tolerance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contract_type"
    t.string "name"
    t.text "scope"
    t.decimal "input_value"
    t.date "billing_date"
    t.decimal "quota_amount"
    t.integer "quotas"
    t.integer "billing_day"
    t.decimal "recurrent_amount"
    t.decimal "scope_ticket_amount"
    t.bigint "corporation_id"
    t.integer "attribuition_model_day"
    t.string "attribuition_model_week_day"
    t.string "attribuition_model_invalid_day"
    t.integer "attribuition_model_validate_day"
    t.integer "recurrent_tickets"
    t.integer "maturity_day"
    t.decimal "total"
    t.decimal "recurring_amount_ticket"
    t.decimal "overplus_ticket_amout"
    t.decimal "extra_hour_amount"
    t.index ["corporation_id"], name: "index_contracts_on_corporation_id"
  end

  create_table "corporation_areas", force: :cascade do |t|
    t.bigint "corporation_id"
    t.bigint "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_corporation_areas_on_area_id"
    t.index ["corporation_id"], name: "index_corporation_areas_on_corporation_id"
  end

  create_table "corporation_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corporation_users", force: :cascade do |t|
    t.bigint "corporation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["corporation_id"], name: "index_corporation_users_on_corporation_id"
    t.index ["user_id"], name: "index_corporation_users_on_user_id"
  end

  create_table "corporations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trading_name"
    t.string "document"
    t.string "phone"
    t.string "contact"
    t.string "role"
    t.string "contact_phone"
    t.string "email"
    t.bigint "corporation_type_id"
    t.index ["corporation_type_id"], name: "index_corporations_on_corporation_type_id"
  end

  create_table "hours", force: :cascade do |t|
    t.bigint "corporation_id"
    t.float "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corporation_id"], name: "index_hours_on_corporation_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "process_depts", force: :cascade do |t|
    t.bigint "area_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_process_depts_on_area_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "contract_id"
    t.string "sponsor"
    t.string "manager"
    t.string "objective"
    t.float "estimate"
    t.text "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.string "type_project"
    t.bigint "area_id"
    t.bigint "corporation_id"
    t.string "code"
    t.index ["area_id"], name: "index_projects_on_area_id"
    t.index ["contract_id"], name: "index_projects_on_contract_id"
    t.index ["corporation_id"], name: "index_projects_on_corporation_id"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "contracts"
  add_foreign_key "appointments", "process_depts"
  add_foreign_key "appointments", "projects"
  add_foreign_key "appointments", "users"
  add_foreign_key "areas", "corporations"
  add_foreign_key "contracts", "corporations"
  add_foreign_key "corporation_areas", "areas"
  add_foreign_key "corporation_areas", "corporations"
  add_foreign_key "corporation_users", "corporations"
  add_foreign_key "corporation_users", "users"
  add_foreign_key "corporations", "corporation_types"
  add_foreign_key "hours", "corporations"
  add_foreign_key "process_depts", "areas"
  add_foreign_key "projects", "areas"
  add_foreign_key "projects", "contracts"
  add_foreign_key "projects", "corporations"
end
