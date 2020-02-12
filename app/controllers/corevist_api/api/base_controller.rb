module CorevistAPI::API
  class BaseController < ActionController::API
    before_action :authenticate_user!
    before_action :prepare_response!
    before_action :set_context

    include ActionController::MimeResponds
    include ActionController::Helpers

    # rescue_from StandardError, with: :handle_exception

    respond_to :json

    helper_method :api_response

    def api_response
      @api_response ||= CorevistAPI::ApiResponse.new
    end

    private

    def set_context
      CorevistAPI::Context.current_user = current_user if current_user
    end

    def prepare_response!
      api_response
    end

    def handle_exception(exception)
      error("api.errors.#{exception}")
    end

    def error(error_or_errors)
      error_or_errors.respond_to?(:each) ? json_array(error_or_errors, 500) : json(error_or_errors, 500)
    end

    def json(message, status)
      render(json: { status: status, errors: [I18n.t(message)] }, status: status)
    end

    def json_array(array, status)
      render(json: { status: status, errors: array }, status: status)
    end
  end
end
