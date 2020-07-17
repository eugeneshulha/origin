module CorevistAPI::Services::Admin::Themes
  class CreateService < CorevistAPI::Services::Base::CreateService
    private

    def object_class
      CorevistAPI::Theme
    end
  end
end
