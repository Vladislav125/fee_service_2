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

ActiveRecord::Schema[7.0].define(version: 2023_11_12_135831) do
  create_table "estates", force: :cascade do |t|
    t.string "cadastral_number"
    t.integer "square"
    t.string "address"
    t.integer "cost"
    t.string "type"
    t.date "reg_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "org_inn"
    t.string "org_kpp"
    t.string "address"
    t.integer "income"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "firstname"
    t.string "surname"
    t.string "middlename"
    t.string "passport"
    t.string "unique"
    t.date "borndate"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "inspector"
    t.boolean "admin"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["passport"], name: "index_users_on_passport", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "state_number"
    t.string "model"
    t.integer "power"
    t.string "type"
    t.date "reg_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
