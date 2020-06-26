class AddColumnsToSAPDowntimes < ActiveRecord::Migration[5.2]
  def change
    add_column :sap_downtimes, :down_from_time, :time unless column_exists?(:sap_downtimes, :down_from_time)
    add_column :sap_downtimes, :down_to_time, :time unless column_exists?(:sap_downtimes, :down_to_time)
    add_column :sap_downtimes, :down_to_date, :date unless column_exists?(:sap_downtimes, :down_to_date)
    add_column :sap_downtimes, :down_from_date, :date unless column_exists?(:sap_downtimes, :down_from_date)
    add_column :sap_downtimes, :timezone, :string unless column_exists?(:sap_downtimes, :timezone)

    remove_column :sap_downtimes, :down_from
    remove_column :sap_downtimes, :down_to
  end
end
