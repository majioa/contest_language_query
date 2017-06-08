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

ActiveRecord::Schema.define(version: 20150227092703) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "language_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages_authors", id: false, force: :cascade do |t|
    t.integer "language_id"
    t.integer "author_id"
  end

  add_index "languages_authors", ["author_id"], name: "index_languages_authors_on_author_id"
  add_index "languages_authors", ["language_id", "author_id"], name: "languages_authors_index", unique: true
  add_index "languages_authors", ["language_id"], name: "index_languages_authors_on_language_id"

  create_table "languages_language_types", id: false, force: :cascade do |t|
    t.integer "language_id"
    t.integer "language_type_id"
  end

  add_index "languages_language_types", ["language_id", "language_type_id"], name: "languages_language_types_index", unique: true
  add_index "languages_language_types", ["language_id"], name: "index_languages_language_types_on_language_id"
  add_index "languages_language_types", ["language_type_id"], name: "index_languages_language_types_on_language_type_id"

end
