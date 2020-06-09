module CorevistAPI::Services::Admin::SystemSettings::DocTypes
  class DestroyService < CorevistAPI::Services::Base::DestroyService
    private

    def object_class
      CorevistAPI::DocType
    end
  end
end
