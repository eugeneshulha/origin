class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name, limit: 50
      t.string :created_by, limit: 50
      t.string :updated_by, limit: 50
      t.boolean :active
      t.boolean :complete
      t.boolean :admin_role
      t.string :assignments, limit: 1020

      t.belongs_to :user
      t.timestamps
    end
  end
end
