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

ActiveRecord::Schema.define(version: 2022_02_03_131027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.integer "created_by"
    t.index ["company_id"], name: "index_car_brands_on_company_id"
  end

  create_table "car_models", force: :cascade do |t|
    t.string "name"
    t.bigint "car_brand_id"
    t.bigint "car_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.integer "created_by"
    t.index ["car_brand_id"], name: "index_car_models_on_car_brand_id"
    t.index ["car_type_id"], name: "index_car_models_on_car_type_id"
    t.index ["company_id"], name: "index_car_models_on_company_id"
  end

  create_table "car_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.integer "created_by"
    t.index ["company_id"], name: "index_car_types_on_company_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer "year"
    t.string "license_plate"
    t.integer "status"
    t.bigint "car_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.integer "created_by"
    t.index ["car_model_id"], name: "index_cars_on_car_model_id"
    t.index ["company_id"], name: "index_cars_on_company_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "company_type"
    t.string "cnpj"
    t.string "phone"
    t.string "address"
    t.string "number"
    t.string "zipcode"
    t.string "district"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.integer "created_by"
    t.index ["city_id"], name: "index_companies_on_city_id"
    t.index ["company_id"], name: "index_companies_on_company_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fine_points", force: :cascade do |t|
    t.string "name"
    t.integer "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.integer "created_by"
    t.index ["company_id"], name: "index_fine_points_on_company_id"
  end

  create_table "fines", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "fine_date"
    t.integer "fine_status"
    t.string "fine_number"
    t.integer "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "detran_id"
    t.bigint "fine_point_id"
    t.bigint "company_id"
    t.integer "created_by"
    t.index ["company_id"], name: "index_fines_on_company_id"
    t.index ["fine_point_id"], name: "index_fines_on_fine_point_id"
    t.index ["user_id"], name: "index_fines_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "status"
    t.integer "user_type"
    t.bigint "company_id"
    t.integer "created_by"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "car_brands", "companies"
  add_foreign_key "car_models", "car_brands"
  add_foreign_key "car_models", "car_types"
  add_foreign_key "car_models", "companies"
  add_foreign_key "car_types", "companies"
  add_foreign_key "cars", "car_models"
  add_foreign_key "cars", "companies"
  add_foreign_key "cities", "states"
  add_foreign_key "companies", "cities"
  add_foreign_key "companies", "companies"
  add_foreign_key "fine_points", "companies"
  add_foreign_key "fines", "companies"
  add_foreign_key "fines", "fine_points"
  add_foreign_key "fines", "users"
  add_foreign_key "states", "countries"
  add_foreign_key "users", "companies"
end
