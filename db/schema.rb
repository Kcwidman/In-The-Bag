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

ActiveRecord::Schema.define(version: 2020_05_06_174116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bags", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.integer "user_id"
    t.datetime "created_at"
  end

  create_table "discs", force: :cascade do |t|
    t.string "model"
    t.string "brand"
    t.string "color"
    t.string "plastic_type"
    t.integer "weight"
    t.integer "condition"
    t.integer "speed"
    t.integer "glide"
    t.integer "turn"
    t.integer "fade"
    t.text "description"
    t.string "nickname"
    t.integer "user_id"
    t.datetime "created_at"
  end

  create_table "slots", force: :cascade do |t|
    t.integer "bag_id"
    t.integer "disc_id"
    t.integer "position"
  end

end
