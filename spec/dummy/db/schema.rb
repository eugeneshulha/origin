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

ActiveRecord::Schema.define(version: 2020_05_26_140920) do

  create_table "assignable_roles_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.index ["role_id"], name: "index_assignable_roles_users_on_role_id"
    t.index ["user_id"], name: "index_assignable_roles_users_on_user_id"
  end

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
    t.index ["sales_area_id"], name: "index_doc_categories_sales_areas_on_sales_area_id"
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
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "jwt_tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "access_jti", null: false
    t.datetime "access_exp", null: false
    t.string "refresh_jti", null: false
    t.datetime "refresh_exp", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_jwt_tokens_on_user_id"
  end

  create_table "microsites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "created_by", default: "system", null: false
    t.string "updated_by", default: "system"
    t.datetime "created_at", default: "2020-05-27 07:30:47", null: false
    t.datetime "updated_at", default: "2020-05-27 07:30:47"
  end

  create_table "microsites_sales_areas", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "microsite_id"
    t.bigint "sales_area_id"
    t.index ["microsite_id"], name: "index_microsites_sales_areas_on_microsite_id"
    t.index ["sales_area_id"], name: "index_microsites_sales_areas_on_sales_area_id"
  end

  create_table "microsites_territories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "territory_id"
    t.bigint "microsite_id"
    t.index ["microsite_id"], name: "index_microsites_territories_on_microsite_id"
    t.index ["territory_id"], name: "index_microsites_territories_on_territory_id"
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

  create_table "permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.index ["title"], name: "index_permissions_on_title"
  end

  create_table "permissions_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "permission_id"
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_permissions_roles_on_role_id"
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

  create_table "territories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "territory", null: false
    t.string "title", null: false
    t.boolean "selected", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key"
    t.text "df_translation"
    t.text "cst_translation"
    t.string "locale"
    t.bigint "microsite_id"
    t.boolean "status"
    t.string "location_used"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key", "locale"], name: "index_translations_on_key_and_locale"
    t.index ["microsite_id"], name: "index_translations_on_microsite_id"
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
