module CorevistAPI::Services::Admin::SystemSettings::DocTypes
  class IndexService < CorevistAPI::Services::Base::IndexService
    private

    def filter
      result(CorevistAPI::DocType.all)
    end
  end
end
