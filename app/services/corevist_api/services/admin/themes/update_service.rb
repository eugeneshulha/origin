module CorevistAPI::Services::Admin::Themes
  class UpdateService < CorevistAPI::Services::Base::UpdateService
    private

    def object_class
      CorevistAPI::Theme
    end
  end
end
