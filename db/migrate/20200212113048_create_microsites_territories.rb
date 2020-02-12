class CreateMicrositesTerritories < ActiveRecord::Migration[5.2]
  def change
    create_table :microsites_territories do |t|
      t.belongs_to :territory
      t.belongs_to :microsite
    end
  end
end
