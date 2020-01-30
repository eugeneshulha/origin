class CreateHbtmTables < ActiveRecord::Migration[5.2]
  def change
    create_table :roles_sales_areas, id: false do |t|
      t.belongs_to :role
      t.belongs_to :sales_area
    end

    create_table :doc_types_sales_areas, id: false do |t|
      t.belongs_to :doc_type
      t.belongs_to :sales_area
    end

    create_table :doc_categories_sales_areas, id: false do |t|
      t.belongs_to :doc_category
      t.belongs_to :sales_area
    end
  end
end
