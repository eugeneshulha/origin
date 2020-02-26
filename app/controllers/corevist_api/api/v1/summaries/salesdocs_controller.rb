module CorevistAPI
  class API::V1::Summaries::SalesdocsController < API::V1::BaseController
    before_action :authorize_user, only: :index

    MSG_SALESDOCS_LOADED = 'api.summaries.salesdocs'.freeze

    def index
      @result = service_result
      error(@result.errors) if @result.failed?
      success(MSG_SALESDOCS_LOADED, @result.data)
    end

    private

    def type
      "#{action_prefix}_#{action_name}".to_sym
    end
  end
end
