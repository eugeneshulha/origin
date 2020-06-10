module CorevistAPI
  module Forms
    class Admin::Translations::UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :edit_translation_form, on_page: :admin_translations_edit
    end
  end
end
