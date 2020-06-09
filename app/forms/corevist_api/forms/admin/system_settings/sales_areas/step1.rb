module CorevistAPI
  module Forms::Admin::SystemSettings::SalesAreas
    class Step1 < CorevistAPI::Forms::BaseForm
      validate_component :sales_areas_new_form, on_page: :admin_system_settings_sales_areas_create_step_1
    end
  end
end
