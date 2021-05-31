# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_07_215828) do

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "solo_user_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "room_id"
    t.integer "solo_user_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["solo_user_id"], name: "index_messages_on_solo_user_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "post_taker_id"
    t.integer "comment_id"
    t.integer "message_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "post_id"
    t.integer "room_id"
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["post_id"], name: "index_notifications_on_post_id"
    t.index ["post_taker_id"], name: "index_notifications_on_post_taker_id"
    t.index ["room_id"], name: "index_notifications_on_room_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "post_takers", force: :cascade do |t|
    t.integer "post_id"
    t.integer "taker_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_takers_on_post_id"
    t.index ["taker_id"], name: "index_post_takers_on_taker_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.datetime "match_time"
    t.time "match_start"
    t.datetime "deadline"
    t.string "sports"
    t.string "level"
    t.string "area"
    t.string "place"
    t.string "match"
    t.string "category"
    t.text "game_contents"
    t.string "game_image"
    t.integer "partner_id"
    t.string "status"
    t.string "contributor"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_time"
    t.integer "solo_user_id"
    t.index ["solo_user_id"], name: "index_posts_on_solo_user_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "partnar_id"
    t.integer "post_id"
    t.integer "solo_user_id"
    t.index ["post_id"], name: "index_rooms_on_post_id"
    t.index ["solo_user_id"], name: "index_rooms_on_solo_user_id"
  end

  create_table "solo_users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.text "contents"
    t.boolean "sports", null: false
    t.boolean "category", null: false
    t.string "place"
    t.string "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_image"
    t.index ["user_id"], name: "index_solo_users_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.string "sports"
    t.integer "member"
    t.string "play_area"
    t.string "team_level"
    t.string "performance"
    t.text "team_contents"
    t.integer "men"
    t.integer "women"
    t.string "team_image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "accepted", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "solo_users"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "posts"
  add_foreign_key "notifications", "rooms"
  add_foreign_key "post_takers", "posts"
  add_foreign_key "post_takers", "solo_users", column: "taker_id"
  add_foreign_key "posts", "solo_users"
  add_foreign_key "posts", "users"
  add_foreign_key "rooms", "posts"
  add_foreign_key "rooms", "solo_users"
  add_foreign_key "solo_users", "users"
end
