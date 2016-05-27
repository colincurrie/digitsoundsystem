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

ActiveRecord::Schema.define(version: 20160527000450) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "story_id"
    t.integer  "photo_id"
    t.integer  "mixtape_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tune_id"
    t.integer  "video_id"
    t.integer  "event_id"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id"
  add_index "comments", ["mixtape_id", "created_at"], name: "index_comments_on_mixtape_id_and_created_at"
  add_index "comments", ["mixtape_id"], name: "index_comments_on_mixtape_id"
  add_index "comments", ["photo_id", "created_at"], name: "index_comments_on_photo_id_and_created_at"
  add_index "comments", ["photo_id"], name: "index_comments_on_photo_id"
  add_index "comments", ["story_id", "created_at"], name: "index_comments_on_story_id_and_created_at"
  add_index "comments", ["story_id"], name: "index_comments_on_story_id"
  add_index "comments", ["tune_id"], name: "index_comments_on_tune_id"
  add_index "comments", ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"
  add_index "comments", ["video_id"], name: "index_comments_on_video_id"

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "venue",       default: ""
    t.string   "description", default: ""
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mixtapes", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.text     "description"
    t.string   "html"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "score"
  end

  add_index "mixtapes", ["user_id"], name: "index_mixtapes_on_user_id"

  create_table "photos", force: :cascade do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "score",              default: 0
  end

  create_table "stories", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stories", ["user_id", "created_at"], name: "index_stories_on_user_id_and_created_at"
  add_index "stories", ["user_id"], name: "index_stories_on_user_id"

  create_table "tunes", force: :cascade do |t|
    t.string   "url"
    t.string   "artist"
    t.string   "title"
    t.string   "html"
    t.integer  "score",      default: 0
    t.datetime "order"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tunes", ["order"], name: "index_tunes_on_order"
  add_index "tunes", ["user_id"], name: "index_tunes_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "surname"
    t.boolean  "admin",                  default: false
    t.boolean  "mailing_list",           default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.text     "bio",                    default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "url"
    t.integer  "score",       default: 0
    t.datetime "order"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "videos", ["order"], name: "index_videos_on_order"
  add_index "videos", ["user_id"], name: "index_videos_on_user_id"

end
