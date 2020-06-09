module CorevistAPI::Services::Admin::SystemSettings::DocTypes
  class CreateService < CorevistAPI::Services::Base::CreateService
    private

    def object_class
      CorevistAPI::DocType
    end
  end
end
