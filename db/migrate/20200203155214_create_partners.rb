class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      # associations
      t.references :parent_partner
      t.references :sales_area
      t.references :user

      # string fields
      t.string :number,   null: false, default: ''
      t.string :function
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.string :email
      t.string :partner_type
      t.string :language
      t.string :payment_terms
      t.string :postal_address_1
      t.string :postal_address_2
      t.string :postal_address_3
      t.string :street_address_1
      t.string :street_address_2
      t.string :street_address_3

      # boolean fields
      t.boolean :deleted,  null: false, default: false
      t.boolean :assigned, null: false, default: false
      t.boolean :default,  null: false, default: false

      t.timestamps
    end
  end
end
