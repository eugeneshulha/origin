class ModifyUserAndRoleTables < ActiveRecord::Migration[5.2]
  def up
    add_column :roles, :description, :text
    rename_column :roles, :name, :title
    remove_column :roles, :assignments
    remove_column :roles, :complete
    remove_column :roles, :admin_role
    remove_column :roles, :user_id
    drop_table :roles_users
    create_table :roles_users, id: false do |t|
      t.belongs_to :role
      t.belongs_to :user
    end
  end

  def down
    remove_column :roles, :description
    rename_column :roles, :title, :name
    add_column :roles, :assignments, :string
    add_column :roles, :complete, :boolean
    add_column :roles, :admin_role, :boolean
    add_column :roles, :user_id, :bigint
  end
end
