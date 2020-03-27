module CorevistAPI
  class API::V1::PaymentsController < API::V1::BaseController

    def new
      @result = service_for(:page_configs_read, :new_payment).call
    end

    private

    def type
      "#{action_prefix}_#{action_name}".to_sym
    end
  end
end
