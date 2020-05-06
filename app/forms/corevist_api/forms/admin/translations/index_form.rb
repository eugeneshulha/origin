module CorevistAPI
  module Forms
    class Admin::Translations::IndexForm < CorevistAPI::Forms::BaseForm
      validate_component :filter_translations_modal_form, on_page: :admin_translations_filters_new
    end
  end
end
