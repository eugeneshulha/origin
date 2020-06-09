class ChangeSAPConnectionsDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column :sap_connections, :active, :boolean, default: false, null: true
  end
end
