class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :created_by
      t.string :updated_by
      t.timestamps
      t.boolean :active
    end
  end
end
