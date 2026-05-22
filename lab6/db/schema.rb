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

ActiveRecord::Schema[8.1].define(version: 2026_05_22_074630) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.float "budget"
    t.bigint "category_id"
    t.string "client"
    t.datetime "created_at", null: false
    t.date "deadline"
    t.text "description"
    t.date "start_date"
    t.integer "status", default: 0
    t.string "team"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_projects_on_category_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "project_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_taggings_on_project_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "project_id"
    t.string "role"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "projects", "categories"
  add_foreign_key "taggings", "projects"
  add_foreign_key "taggings", "tags"
end
