class ChangeDocCategoriesAssociation < ActiveRecord::Migration[5.2]
  def change
    change_table :doc_categories_sales_areas do |t|
      t.remove :doc_category_id
      t.string :doc_category_id, index: true, foreign_key: true
    end
  end
end
