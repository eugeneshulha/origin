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

ActiveRecord::Schema.define(version: 2020_02_12_133658) do

  create_table "doc_categories", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doc_categories_sales_areas", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sales_area_id"
    t.string "doc_category_id"
  end

  create_table "doc_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "data"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doc_types_sales_areas", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "doc_type_id"
    t.bigint "sales_area_id"
    t.index ["doc_type_id"], name: "index_doc_types_sales_areas_on_doc_type_id"
    t.index ["sales_area_id"], name: "index_doc_types_sales_areas_on_sales_area_id"
  end

  create_table "jwt_blacklist", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "microsites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "partners", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "parent_partner_id"
    t.bigint "sales_area_id"
    t.bigint "user_id"
    t.string "number", default: "", null: false
    t.string "function"
    t.string "name"
    t.string "state"
    t.string "country"
    t.string "city"
    t.string "house"
    t.string "postal_code"
    t.string "email"
    t.string "partner_type"
    t.string "language"
    t.string "payment_terms"
    t.string "postal_address_1"
    t.string "postal_address_2"
    t.string "postal_address_3"
    t.string "street_address_1"
    t.string "street_address_2"
    t.string "street_address_3"
    t.boolean "deleted", default: false, null: false
    t.boolean "assigned", default: false, null: false
    t.boolean "default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_partner_id"], name: "index_partners_on_parent_partner_id"
    t.index ["sales_area_id"], name: "index_partners_on_sales_area_id"
    t.index ["user_id"], name: "index_partners_on_user_id"
  end

  create_table "privileges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_privileges_on_title"
  end

  create_table "privileges_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "privilege_id"
    t.index ["privilege_id"], name: "index_privileges_roles_on_privilege_id"
    t.index ["role_id"], name: "index_privileges_roles_on_role_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 50
    t.text "description"
    t.string "created_by", limit: 50
    t.string "updated_by", limit: 50
    t.boolean "active", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "roles_sales_areas", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "sales_area_id"
    t.index ["role_id"], name: "index_roles_sales_areas_on_role_id"
    t.index ["sales_area_id"], name: "index_roles_sales_areas_on_sales_area_id"
  end

  create_table "roles_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "sales_areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "created_by"
    t.string "updated_by"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_classifications", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", default: "", null: false
  end

  create_table "user_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "value"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "username", limit: 50, null: false
    t.string "encrypted_password", null: false
    t.string "last_name", limit: 50, null: false
    t.string "first_name", limit: 50, null: false
    t.string "email", limit: 100, null: false
    t.string "user_type", limit: 30
    t.string "phone", limit: 30
    t.string "date_format", limit: 20
    t.string "number_format", limit: 2
    t.string "time_format", limit: 20
    t.string "time_zone"
    t.string "language", limit: 5
    t.boolean "active", default: false
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
    t.bigint "microsite_id"
    t.bigint "user_type_id"
    t.string "created_by", limit: 50
    t.string "updated_by", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_classification_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["microsite_id"], name: "index_users_on_microsite_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
    t.index ["username"], name: "index_users_on_username", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

end
