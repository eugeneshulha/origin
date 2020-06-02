class AddFieldsToSAPConnections < ActiveRecord::Migration[5.2]
  def change
    add_column :sap_connections, :env, :integer, null: false, default: 0

    add_column :sap_connections, :created_by, :string, null: false, default: :system
    add_column :sap_connections, :updated_by, :string, default: :system
    add_column :sap_connections, :created_at, :datetime, null: false, default: DateTime.now
    add_column :sap_connections, :updated_at, :datetime, default: DateTime.now
  end
end
