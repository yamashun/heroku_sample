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

ActiveRecord::Schema.define(version: 2019_10_05_140115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_clients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "client_id"
    t.string "redirect_uri"
    t.string "encrypted_client_secret"
    t.string "encrypted_code"
    t.string "encrypted_access_token"
    t.string "encrypted_refresh_token"
    t.string "permitted_scope"
    t.integer "client_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_base_clients_on_user_id"
  end

  create_table "base_coupons", force: :cascade do |t|
    t.bigint "base_client_id"
    t.string "code", null: false
    t.string "name"
    t.integer "discount_price"
    t.integer "discount_ratio"
    t.integer "number"
    t.integer "minimum_price"
    t.datetime "available_from"
    t.datetime "available_to"
    t.integer "used_number"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["base_client_id"], name: "index_base_coupons_on_base_client_id"
  end

  create_table "base_items", force: :cascade do |t|
    t.bigint "base_user_id", null: false
    t.integer "item_id"
    t.string "title"
    t.string "detail"
    t.integer "price"
    t.integer "proper_price"
    t.integer "item_tax_type"
    t.integer "stock"
    t.integer "visible"
    t.integer "list_order"
    t.string "identifier"
    t.integer "modified"
    t.string "img1_origin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["base_user_id"], name: "index_base_items_on_base_user_id"
  end

  create_table "base_users", force: :cascade do |t|
    t.bigint "base_client_id", null: false
    t.bigint "user_id"
    t.string "shop_id"
    t.string "shop_name"
    t.string "shop_introduction"
    t.string "twitter_id"
    t.string "facebook_id"
    t.string "ameba_id"
    t.string "instagram_id"
    t.string "background_url"
    t.integer "display_background"
    t.integer "repeat_background"
    t.string "logo"
    t.integer "display_logo"
    t.string "mail_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["base_client_id"], name: "index_base_users_on_base_client_id"
    t.index ["user_id"], name: "index_base_users_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pre_user_registrations", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "expiration_datetime"
    t.string "mail_address"
    t.string "password_digest"
    t.string "verify_token"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_pre_user_registrations_on_user_id"
  end

  create_table "registered_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "user_type"
    t.integer "register_status"
    t.string "nickname"
    t.string "mail_address"
    t.string "phone_number"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_registered_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "base_clients", "users"
  add_foreign_key "base_items", "base_users"
  add_foreign_key "base_users", "base_clients"
  add_foreign_key "registered_users", "users"
end
