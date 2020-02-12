class CreatePrivileges < ActiveRecord::Migration[5.2]
  def change
    create_table :privileges do |t|
      t.string :title, index: true
      t.text :description

      t.timestamps
    end

    create_table :privileges_roles, id: false do |t|
      t.belongs_to :role, index: true
      t.belongs_to :privilege, index: true
    end
  end
end
