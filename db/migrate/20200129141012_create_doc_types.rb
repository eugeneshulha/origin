class CreateDocTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :doc_types do |t|
      t.string :title
      t.text   :description
      t.text   :data
      t.string :created_by
      t.string :updated_by
      t.timestamps
    end
  end
end
