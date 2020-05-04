module CorevistAPI
  module Forms
    module Admin
      module Translations
        class CreateForm < CorevistAPI::Forms::BaseForm
          validate_component :new_translation_form, on_page: :admin_translations_new
        end
      end
    end
  end
end
