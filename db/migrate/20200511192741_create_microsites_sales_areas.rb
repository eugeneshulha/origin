class CreateMicrositesSalesAreas < ActiveRecord::Migration[5.2]
  def up
    create_table :microsites_sales_areas, id: false do |t|
      t.belongs_to :microsite, index: true
      t.belongs_to :sales_area, index: true
    end

    drop_table :roles_sales_areas
  end

  def down
    create_table :roles_sales_areas, id: false do |t|
      t.belongs_to :role
      t.belongs_to :sales_area
    end

    drop_table :microsites_sales_areas
  end
end
