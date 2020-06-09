module CorevistAPI::Services::Admin::SystemSettings::Microsites
  class UpdateService < CorevistAPI::Services::Base::UpdateService
    private

    def object_class
      CorevistAPI::Microsite
    end
  end
end
