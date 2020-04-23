class CreatePermissions < ActiveRecord::Migration[5.2]
  def up
    create_table :permissions do |t|
      t.string :title, index: true, null: false
      t.text   :description
    end

    create_table :permissions_roles, id: false do |t|
      t.belongs_to :role, index: true
      t.belongs_to :permission, index: true
    end

    drop_table :privileges
    drop_table :privileges_roles
  end

  def down
    create_table :privileges do |t|
      t.string :title
      t.text   :description

      t.timestamps
    end

    create_table :privileges_roles, id: false do |t|
      t.belongs_to :role, index: true
      t.belongs_to :privilege, index: true
    end

    drop_table :permissions
    drop_table :permissions_roles
  end
end
