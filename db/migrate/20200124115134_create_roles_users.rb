class CreateRolesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :roles_users, id: false do |t|
      t.integer :roles_id
      t.integer :users_id
    end

    add_index :roles_users, :roles_id
    add_index :roles_users, :users_id
  end
end
