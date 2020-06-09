module CorevistAPI
  module Forms::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class CreateForm < CorevistAPI::Forms::BaseForm
      validate_component :sap_downtime_create_form, on_page: :admin_system_settings_sap_maintenance_sap_downtimes_new
    end
  end
end
