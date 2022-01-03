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

ActiveRecord::Schema.define(version: 2022_01_01_134559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "horse_details", force: :cascade do |t|
    t.string "horse_type"
    t.bigint "horse_id"
    t.date "date", null: false
    t.text "weather", null: false
    t.text "race_name", null: false
    t.string "ranking", null: false
    t.string "popularity", null: false
    t.text "jockey", null: false
    t.text "race_condition", null: false
    t.string "race_distance", null: false
    t.float "time", null: false
    t.float "dressing_difference_time", null: false
    t.string "body_weight", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["horse_type", "horse_id"], name: "index_horse_details_on_horse"
  end

  create_table "horses", force: :cascade do |t|
    t.string "name"
    t.text "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_horses_on_name", unique: true
  end

end
