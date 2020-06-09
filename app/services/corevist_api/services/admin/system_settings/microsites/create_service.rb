module CorevistAPI::Services::Admin::SystemSettings::Microsites
  class CreateService < CorevistAPI::Services::Base::CreateService
    private

    def object_class
      CorevistAPI::Microsite
    end
  end
end
