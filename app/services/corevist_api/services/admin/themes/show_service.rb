module CorevistAPI::Services::Admin::Themes
  class ShowService < CorevistAPI::Services::Base::ShowService
    private

    def object_class
      CorevistAPI::Theme
    end
  end
end
