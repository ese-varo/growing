ActiveRecord::Schema.define(version: 2021_04_09_012511) do

  enable_extension "plpgsql"

  create_table "checkpoints", force: :cascade do |t|
    t.string "title"
    t.boolean "status", default: false
    t.text "description"
    t.date "due_date"
    t.bigint "habit_id", null: false
    t.bigint "day_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["day_id"], name: "index_checkpoints_on_day_id"
    t.index ["habit_id"], name: "index_checkpoints_on_habit_id"
  end

  create_table "days", force: :cascade do |t|
    t.boolean "status", default: false
    t.date "date"
    t.bigint "habit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["habit_id"], name: "index_days_on_habit_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.date "start_date"
    t.date "end_date"
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "description"
    t.string "noteable_type", null: false
    t.bigint "noteable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["noteable_type", "noteable_id"], name: "index_notes_on_noteable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "checkpoints", "days"
  add_foreign_key "checkpoints", "habits"
  add_foreign_key "days", "habits"
  add_foreign_key "habits", "users"
end
