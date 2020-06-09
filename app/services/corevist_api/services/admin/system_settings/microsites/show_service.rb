module CorevistAPI::Services::Admin::SystemSettings::Microsites
  class ShowService < CorevistAPI::Services::Base::ShowService
    private

    def object_class
      CorevistAPI::Microsite
    end
  end
end
