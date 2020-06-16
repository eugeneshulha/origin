module CorevistAPI
  module Forms::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :sap_downtime_edit_form, on_page: :admin_system_settings_sap_maintenance_sap_downtimes_edit
    end
  end
end
