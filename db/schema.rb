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

ActiveRecord::Schema[7.0].define(version: 2023_11_20_192548) do
  create_table "estates", force: :cascade do |t|
    t.string "cadastral_number", null: false
    t.integer "square", null: false
    t.string "address", null: false
    t.integer "cost", null: false
    t.string "estate_type", null: false
    t.date "reg_date", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_estates_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "org_inn", null: false
    t.string "org_kpp", null: false
    t.string "address", null: false
    t.integer "income", null: false
    t.date "reg_date", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "service_estates", force: :cascade do |t|
    t.string "cadastral_number", null: false
    t.integer "square", null: false
    t.string "address", null: false
    t.integer "cost", null: false
    t.string "estate_type", null: false
    t.date "reg_date", null: false
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_service_estates_on_organization_id"
  end

  create_table "service_vehicles", force: :cascade do |t|
    t.string "state_number", null: false
    t.string "model", null: false
    t.integer "power", null: false
    t.string "vehicle_type", null: false
    t.date "reg_date", null: false
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_service_vehicles_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "snils", null: false
    t.string "inn", null: false
    t.string "ipid"
    t.string "password_digest"
    t.string "passport", null: false
    t.string "surname", null: false
    t.string "firstname", null: false
    t.string "middlename"
    t.date "born_date", null: false
    t.string "address", null: false
    t.integer "income", default: 0, null: false
    t.boolean "admin", default: false
    t.boolean "inspector", default: false
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "state_number", null: false
    t.string "model", null: false
    t.integer "power", null: false
    t.string "vehicle_type", null: false
    t.date "reg_date", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

end
