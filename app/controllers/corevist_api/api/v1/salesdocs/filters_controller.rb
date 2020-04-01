module CorevistAPI
  class API::V1::Salesdocs::FiltersController < API::V1::BaseController
    def new
      @result = service_for(:page_configs_read, :filter_salesdocs_modal).call
    end
  end
end
