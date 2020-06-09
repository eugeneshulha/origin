module CorevistAPI::Services::Admin::Translations
  class DestroyService < CorevistAPI::Services::Base::DestroyService
    private

    def object_class
      CorevistAPI::Translation
    end
  end
end
