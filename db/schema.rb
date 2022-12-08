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

ActiveRecord::Schema[7.0].define(version: 2016_06_29_203434) do
  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "story_id"
    t.bigint "photo_id"
    t.bigint "mixtape_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tune_id"
    t.bigint "video_id"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_comments_on_event_id"
    t.index ["mixtape_id", "created_at"], name: "index_comments_on_mixtape_id_and_created_at"
    t.index ["mixtape_id"], name: "index_comments_on_mixtape_id"
    t.index ["photo_id", "created_at"], name: "index_comments_on_photo_id_and_created_at"
    t.index ["photo_id"], name: "index_comments_on_photo_id"
    t.index ["story_id", "created_at"], name: "index_comments_on_story_id_and_created_at"
    t.index ["story_id"], name: "index_comments_on_story_id"
    t.index ["tune_id"], name: "index_comments_on_tune_id"
    t.index ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "venue", default: ""
    t.string "description", default: ""
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean "all_day"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mixtapes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.text "description"
    t.string "html"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score"
    t.index ["user_id"], name: "index_mixtapes_on_user_id"
  end

  create_table "photos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score", default: 0
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "stories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_position"
    t.index ["user_id", "created_at"], name: "index_stories_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "tunes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "url"
    t.string "artist"
    t.string "title"
    t.string "html"
    t.integer "score", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tunes_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "surname"
    t.boolean "admin", default: false
    t.boolean "mailing_list", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bio"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "url"
    t.integer "score", default: 0
    t.timestamp "order"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order"], name: "index_videos_on_order"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  add_foreign_key "comments", "events"
  add_foreign_key "comments", "mixtapes"
  add_foreign_key "comments", "photos"
  add_foreign_key "comments", "stories"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "videos"
  add_foreign_key "mixtapes", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "tunes", "users"
  add_foreign_key "videos", "users"
end
