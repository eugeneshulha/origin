class CreateDocCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :doc_categories, id: :string do |t|
      t.string :title
      t.text   :description
      t.string :created_by
      t.string :updated_by
      t.timestamps
    end
  end
end
