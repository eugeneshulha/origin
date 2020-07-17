class CreateThemesAndConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.string :title, null: false
      t.string :host, null: false
    end

    create_table :theme_configurations do |t|
      t.string :key, null: false, index: true
      t.string :value, null: false
      t.string :type
    end
  end
end
