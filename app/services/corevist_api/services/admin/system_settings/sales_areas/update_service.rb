module CorevistAPI::Services::Admin::SystemSettings::SalesAreas
  class UpdateService < CorevistAPI::Services::Base::UpdateService
    private

    def object_class
      CorevistAPI::SalesArea
    end
  end
end
