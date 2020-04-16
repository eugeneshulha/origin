class RemoveUserTypeStringFromUser < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :user_type, :string
  end

  def down
    add_column :users, :user_type, :string
  end
end
