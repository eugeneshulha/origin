module CorevistAPI
  module Forms::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :sap_connection_edit_form, on_page: :admin_system_settings_sap_maintenance_sap_connections_edit
    end
  end
end
