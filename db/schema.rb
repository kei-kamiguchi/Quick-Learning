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

ActiveRecord::Schema.define(version: 2020_05_22_051321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achieveds", force: :cascade do |t|
    t.integer "user_id"
    t.integer "part_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_choice_categories", force: :cascade do |t|
    t.integer "admin_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_participations", force: :cascade do |t|
    t.integer "admin_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "admin", default: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["invitation_token"], name: "index_admins_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_admins_on_invitations_count"
    t.index ["invited_by_id"], name: "index_admins_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_admins_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_categories_on_project_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "question_id"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_comments_on_admin_id"
    t.index ["question_id"], name: "index_comments_on_question_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subject_id"
    t.index ["subject_id"], name: "index_parts_on_subject_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_projects_on_admin_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "part_id"
    t.boolean "checked_by_admin", default: false
    t.string "checker"
    t.boolean "reply", default: true
    t.boolean "checked_by_user", default: true
    t.index ["part_id"], name: "index_questions_on_part_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_subjects_on_category_id"
    t.index ["project_id"], name: "index_subjects_on_project_id"
  end

  create_table "test_questions", force: :cascade do |t|
    t.string "title"
    t.text "content", null: false
    t.integer "form_size", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "test_id"
    t.index ["test_id"], name: "index_test_questions_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subject_id"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_tests_on_project_id"
    t.index ["subject_id"], name: "index_tests_on_subject_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "test_question_id"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_choice_categories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_participations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "categories", "projects"
  add_foreign_key "comments", "admins"
  add_foreign_key "comments", "questions"
  add_foreign_key "comments", "users"
  add_foreign_key "parts", "subjects"
  add_foreign_key "projects", "admins"
  add_foreign_key "questions", "parts"
  add_foreign_key "questions", "users"
  add_foreign_key "subjects", "categories"
  add_foreign_key "subjects", "projects"
  add_foreign_key "test_questions", "tests"
  add_foreign_key "tests", "projects"
  add_foreign_key "tests", "subjects"
end
