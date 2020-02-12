class CreateTerritories < ActiveRecord::Migration[5.2]
  def change
    create_table :territories do |t|
      t.string :territory, null: false
      t.string :title, null: false
      t.boolean :selected, default: false

      t.timestamps
    end
  end
end
