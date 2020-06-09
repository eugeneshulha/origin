module CorevistAPI::Forms::Admin::SystemSettings::DocTypes
  class UpdateForm < CorevistAPI::Forms::BaseForm
    validate_component :doc_type_update_form, on_page: :admin_system_settings_doc_types_update
  end
end
