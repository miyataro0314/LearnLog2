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

ActiveRecord::Schema[7.1].define(version: 2024_03_04_115025) do
  create_table "daily_notes", force: :cascade do |t|
    t.date "date", null: false
    t.integer "today_goal", null: false
    t.string "quote"
    t.integer "mood"
    t.text "content"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_daily_notes_on_date"
    t.index ["user_id", "date"], name: "index_daily_notes_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_daily_notes_on_user_id"
  end

  create_table "logs", force: :cascade do |t|
    t.date "date", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at"
    t.integer "user_id", null: false
    t.integer "daily_note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_note_id"], name: "index_logs_on_daily_note_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "mantras", force: :cascade do |t|
    t.string "author"
    t.string "body"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mantras_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "avatar"
    t.integer "week_goal"
    t.integer "mantra_config"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "salt", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "daily_notes", "users"
  add_foreign_key "logs", "daily_notes"
  add_foreign_key "logs", "users"
  add_foreign_key "mantras", "users"
  add_foreign_key "profiles", "users"
end
