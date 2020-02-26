module CorevistAPI
  class API::V1::Summaries::SalesdocsController < API::V1::BaseController
    before_action :authorize_user, only: :index
    before_action :perform_action, only: %i[index]

    def index; end

    private

    def type
      "#{action_prefix}_#{action_name}".to_sym
    end
  end
end
