module CorevistAPI::Services::Admin::Translations
  class UpdateService < CorevistAPI::Services::Base::UpdateService
    private

    def object_class
      CorevistAPI::Translation
    end
  end
end
