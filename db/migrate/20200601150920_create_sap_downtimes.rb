class CreateSAPDowntimes < ActiveRecord::Migration[5.2]
  def change
    create_table :sap_downtimes do |t|
      t.string :title
      t.string :description

      t.datetime :down_from
      t.datetime :down_to


      t.boolean :active, null: false

      t.string :created_by
      t.string :updated_by
      t.timestamps
    end
  end
end
