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

ActiveRecord::Schema[7.0].define(version: 2023_12_04_184256) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "estates", force: :cascade do |t|
    t.string "cadastral_number", null: false
    t.integer "square", null: false
    t.string "address", null: false
    t.integer "cost", null: false
    t.string "estate_type", null: false
    t.integer "tax", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.text "text_field", null: false
    t.string "preview", null: false
    t.integer "receiver", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "ownerships", force: :cascade do |t|
    t.date "reg_date", null: false
    t.date "end_date", null: false
    t.integer "income", default: 0
    t.integer "tax_sum", default: 0
    t.boolean "paid", default: false
    t.integer "user_id", null: false
    t.integer "vehicle_id"
    t.integer "estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "snils"
    t.string "inn", null: false
    t.string "kpp"
    t.string "ipid"
    t.string "password_digest"
    t.string "passport"
    t.string "surname"
    t.string "firstname", null: false
    t.string "middlename"
    t.date "born_date", null: false
    t.string "address", null: false
    t.integer "balance", default: 0, null: false
    t.boolean "admin", default: false
    t.boolean "inspector", default: false
    t.boolean "organization", default: false
    t.string "remember_digest"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_users_on_user_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vin", null: false
    t.string "state_number", null: false
    t.string "model", null: false
    t.integer "power", null: false
    t.string "vehicle_type", null: false
    t.integer "tax", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
