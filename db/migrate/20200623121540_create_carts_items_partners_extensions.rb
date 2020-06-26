class CreateCartsItemsPartnersExtensions < ActiveRecord::Migration[5.2]
  def change
    create_table :carts, id: false, primary_key: :uuid do |t|
      t.primary_key :uuid, :string
      t.references :user, null: false
      t.string :title
      t.string :po_number
      t.references :doc_type
      t.references :sales_area
      t.string :rdd
      t.string :valid_from, default: '00000000'
      t.string :valid_to, default: '00000000'
      t.string :delivery_block
      t.string :phone
      t.string :flags
      t.string :ref_doc_nr
      t.string :ref_doc_cat
      t.string :text_ids
      t.string :item_text_ids
      t.boolean :customer_material, default: true
      t.integer :price_print_flag
      t.boolean :active, null: false, default: false
      t.string :created_by, null: false, default: :system
      t.string :updated_by, default: :system
      t.timestamps
    end

    create_table :cart_items do |t|
      t.string :cart_uuid, null: false
      t.string :material, null: false
      t.string :quantity, null: false
      t.string :rdd
      t.string :unit
      t.string :ref_doc_nr
      t.string :ref_doc_cat
      t.string :ref_item_nr
      t.string :created_by, null: false, default: :system
      t.string :updated_by, default: :system
      t.timestamps
    end

    add_foreign_key :cart_items, :carts, column: :cart_uuid, primary_key: :uuid, on_delete: :cascade

    create_table :cart_extensions do |t|
      t.string :cart_uuid, null: false
      t.string :name
      t.string :value
      t.string :created_by, null: false, default: :system
      t.string :updated_by, default: :system
      t.timestamps
    end

    add_foreign_key :cart_extensions, :carts, column: :cart_uuid, primary_key: :uuid, on_delete: :cascade

    create_table :cart_partners do |t|
      t.string :cart_uuid, null: false
      t.string :number
      t.string :function
      t.string :item_number, default: '000000'
      t.string :created_by, null: false, default: :system
      t.string :updated_by, default: :system
      t.timestamps
    end

    add_foreign_key :cart_partners, :carts, column: :cart_uuid, primary_key: :uuid, on_delete: :cascade
  end
end
