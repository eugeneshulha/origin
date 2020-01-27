class CreateMicrosites < ActiveRecord::Migration[5.2]
  def change
    create_table :microsites do |t|
      t.string :name, null: false
    end
  end
end
