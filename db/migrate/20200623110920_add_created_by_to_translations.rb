class AddCreatedByToTranslations < ActiveRecord::Migration[5.2]
  def change
    add_column :translations, :created_by, :string
  end
end
