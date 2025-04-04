# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_03_203844) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "plans", force: :cascade do |t|
    t.integer "plan_type"
    t.bigint "user_id", null: false
    t.date "start_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "weeks", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.integer "position", null: false
    t.jsonb "chapters_data", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.jsonb "memory_verse_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id", "position"], name: "index_weeks_on_plan_id_and_position", unique: true
    t.index ["plan_id", "start_date", "end_date"], name: "index_weeks_on_plan_id_and_start_date_and_end_date", unique: true
    t.index ["plan_id"], name: "index_weeks_on_plan_id"
  end

  add_foreign_key "plans", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "weeks", "plans"
end
