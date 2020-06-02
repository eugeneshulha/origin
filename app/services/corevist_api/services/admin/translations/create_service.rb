module CorevistAPI::Services::Admin::Translations
  class CreateService < CorevistAPI::Services::Base::CreateService
    private

    def object_class
      CorevistAPI::Translation
    end
  end
end
