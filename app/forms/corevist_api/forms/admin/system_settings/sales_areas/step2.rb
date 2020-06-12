module CorevistAPI
  module Forms::Admin::SystemSettings::SalesAreas
    class Step2 < CorevistAPI::Forms::BaseForm
      validate_component :doc_types_of_sales_area_form,
                         on_page: :admin_system_settings_sales_areas_create_step_2
    end
  end
end