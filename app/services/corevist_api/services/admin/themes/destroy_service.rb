module CorevistAPI::Services::Admin::Themes
  class DestroyService < CorevistAPI::Services::Base::DestroyService
    private

    def object_class
      CorevistAPI::Theme
    end
  end
end
