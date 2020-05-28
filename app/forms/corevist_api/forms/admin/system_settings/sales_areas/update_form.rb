module CorevistAPI
  module Forms::Admin::SystemSettings::SalesAreas
    class UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :sales_area_update_form, on_page: :admin_system_settings_sales_areas_update
    end
  end
end
