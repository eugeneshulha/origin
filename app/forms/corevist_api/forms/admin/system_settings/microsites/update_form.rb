module CorevistAPI
  module Forms::Admin::SystemSettings::Microsites
    class UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :microsite_update_form, on_page: :admin_system_settings_microsites_update
    end
  end
end
