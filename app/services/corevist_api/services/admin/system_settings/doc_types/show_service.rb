module CorevistAPI::Services::Admin::SystemSettings::DocTypes
  class ShowService < CorevistAPI::Services::Base::ShowService
    private

    def object_class
      CorevistAPI::DocType
    end
  end
end
