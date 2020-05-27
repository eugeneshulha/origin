module CorevistAPI
  module Forms::Admin::SystemSettings::Microsites
    class CreateForm < CorevistAPI::Forms::BaseForm
      validate_component :microsite_create_form, on_page: :admin_system_settings_microsites_create
    end
  end
end
