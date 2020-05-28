module CorevistAPI
  module Forms::Admin::SystemSettings::SalesAreas
    class CreateForm < CorevistAPI::Forms::BaseForm
      validate_component :sales_area_create_form, on_page: :admin_system_settings_sales_areas_create
    end
  end
end
