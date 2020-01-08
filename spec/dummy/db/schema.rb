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

ActiveRecord::Schema.define(version: 2019_12_23_151414) do

  create_table "jwt_blacklist", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", default: "b763aed0-203e-4b9b-b2ba-b5e1b5911ce6", null: false
    t.string "username", limit: 50, null: false
    t.string "encrypted_password", null: false
    t.string "last_name", limit: 50, null: false
    t.string "first_name", limit: 50, null: false
    t.string "email", limit: 100, null: false
    t.string "microsite", limit: 50, null: false
    t.string "user_type", limit: 30
    t.string "phone", limit: 30
    t.string "type", limit: 30
    t.string "date_format", limit: 20
    t.string "number_format", limit: 2
    t.string "time_format", limit: 20
    t.string "language", limit: 5
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "created_by", limit: 50
    t.string "updated_by", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["username"], name: "index_users_on_username"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

end
