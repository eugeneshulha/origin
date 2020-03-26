module CorevistAPI
  class API::V1::AccountDetailsController < API::V1::BaseController
    include CorevistAPI::UserSpecific

    before_action :perform_action, only: %i[show]

    def show; end

    private

    def type
      "#{action_prefix}_#{action_name}".to_sym
    end
  end
end
