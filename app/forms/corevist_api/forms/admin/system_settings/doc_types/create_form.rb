module CorevistAPI::Forms::Admin::SystemSettings::DocTypes
  class CreateForm < CorevistAPI::Forms::BaseForm
    validate_component :doc_type_create_form, on_page: :admin_system_settings_doc_types_create
  end
end
