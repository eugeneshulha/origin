class CreateTranslations < ActiveRecord::Migration[5.2]
  def up
    # TODO: consider presence of table in qa database
    return if table_exists?(:translations)

    create_table :translations do |t|
      t.string :key
      t.text :df_translation
      t.text :cst_translation
      t.string :locale
      t.references :microsite
      t.boolean :status
      t.string :location_used
      t.string :updated_by
      t.timestamps
    end

    add_index :translations, %i[key locale]
  end

  def down
    drop_table :translations
  end
end
