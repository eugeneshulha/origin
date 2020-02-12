class ChangeDocCategoriesAssociation < ActiveRecord::Migration[5.2]
  def up
    remove_column :doc_categories_sales_areas, :doc_category_id

    change_table :doc_categories_sales_areas do |t|
      t.string :doc_category_id, index: true, foreign_key: true
    end
  end

  def down
    remove_index :doc_categories_sales_areas, name: :index_doc_categories_sales_areas_on_sales_area_id
    remove_column :doc_categories_sales_areas, :doc_category_id

    change_table :doc_categories_sales_areas do |t|
      t.belongs_to :doc_category
    end
  end
end
