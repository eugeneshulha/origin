module CorevistAPI::Services::Admin::SystemSettings::DocTypes
  class UpdateService < CorevistAPI::Services::Base::UpdateService
    private

    def object_class
      CorevistAPI::DocType
    end
  end
end
