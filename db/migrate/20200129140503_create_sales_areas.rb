class CreateSalesAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_areas do |t|
      t.string :title
      t.text   :description
      t.string :created_by
      t.string :updated_by
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
