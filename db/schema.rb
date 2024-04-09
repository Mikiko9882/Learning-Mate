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

ActiveRecord::Schema[7.1].define(version: 2024_04_07_221726) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grades", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "max_scores", force: :cascade do |t|
    t.integer "max_score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_names", force: :cascade do |t|
    t.string "test_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_results", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "test_name_id"
    t.bigint "subject_id"
    t.bigint "max_score_id"
    t.integer "score", null: false
    t.integer "preparation_time_minutes", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "achievement_rate"
    t.index ["max_score_id"], name: "index_test_results_on_max_score_id"
    t.index ["subject_id"], name: "index_test_results_on_subject_id"
    t.index ["test_name_id"], name: "index_test_results_on_test_name_id"
    t.index ["user_id"], name: "index_test_results_on_user_id"
  end

  create_table "user_classes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login_id", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "nickname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "grade_id"
    t.bigint "user_class_id"
    t.integer "role", default: 0, null: false
    t.index ["grade_id"], name: "index_users_on_grade_id"
    t.index ["login_id"], name: "index_users_on_login_id", unique: true
    t.index ["user_class_id"], name: "index_users_on_user_class_id"
  end

  add_foreign_key "test_results", "max_scores"
  add_foreign_key "test_results", "subjects"
  add_foreign_key "test_results", "test_names"
  add_foreign_key "test_results", "users"
  add_foreign_key "users", "grades"
  add_foreign_key "users", "user_classes"
end
