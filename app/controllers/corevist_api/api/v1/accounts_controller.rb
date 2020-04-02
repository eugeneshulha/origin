module CorevistAPI
  class API::V1::AccountsController < API::V1::BaseController
    include CorevistAPI::UserSpecific

    def show; end

    private

    def type
      "#{action_prefix}_#{action_name}".to_sym
    end
  end
end
