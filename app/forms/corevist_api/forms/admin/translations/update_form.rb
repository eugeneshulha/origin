module CorevistAPI
  module Forms
    class Admin::Translations::UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :update_translation_form, on_page: :admin_translations_update
    end
  end
end