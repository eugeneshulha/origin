class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :title,       limit: 50
      t.text   :description
      t.string :created_by, limit: 50
      t.string :updated_by, limit: 50
      t.boolean :active,    default: false

      t.belongs_to :user
      t.timestamps
    end
  end
end
