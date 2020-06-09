module CorevistAPI::Services::Admin::SystemSettings::Microsites
  class DestroyService < CorevistAPI::Services::Base::DestroyService
    private

    def object_class
      CorevistAPI::Microsite
    end
  end
end
