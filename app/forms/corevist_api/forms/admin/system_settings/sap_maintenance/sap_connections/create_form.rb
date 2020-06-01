module CorevistAPI
  module Forms::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class CreateForm < CorevistAPI::Forms::BaseForm
      validate_component :sap_connection_create_form, on_page: :admin_system_settings_sap_maintenance_sap_connections_new
    end
  end
end
