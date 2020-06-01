class CreateSAPConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :sap_connections do |t|
      t.string :title
      t.string :description

      t.string :mshost
      t.string :ashost
      t.string :sysnr
      t.string :client
      t.string :user
      t.string :passwd
      t.string :lang
      t.string :trace
      t.string :loglevel

      t.boolean :active, null: false, default: false
    end
  end
end
