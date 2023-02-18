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

ActiveRecord::Schema[7.0].define(version: 2023_02_18_031142) do
  create_table "exchanges", force: :cascade do |t|
    t.integer "invite_code"
    t.string "address_1"
    t.integer "address_1_lat"
    t.integer "address_1_lng"
    t.string "address_2"
    t.integer "address_2_lat"
    t.integer "address_2_lng"
    t.string "meeting_address"
    t.integer "meeting_address_lat"
    t.integer "meeting_address_lng"
    t.datetime "meettime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "reviewer_id"
    t.integer "reviewed_id"
    t.integer "exchange_id"
    t.integer "rating"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_exchanges", force: :cascade do |t|
    t.integer "user_id"
    t.integer "exchange_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "address"
    t.string "state"
    t.integer "zipcode"
    t.integer "lat"
    t.integer "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
