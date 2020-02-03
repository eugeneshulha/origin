class DropAssignedPartners < ActiveRecord::Migration[5.2]
  def up
    drop_table :assigned_partners
  end

  def down
    create_table :assigned_partners do |t|
      t.string :number, limit: 10
      t.string :name, limit: 100
      t.string :sales_area, limit: 8
      t.boolean :enabled
      t.string :function, limit: 2

      t.belongs_to :user
      t.timestamps
    end
  end
end

