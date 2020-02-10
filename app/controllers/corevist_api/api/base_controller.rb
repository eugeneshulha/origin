module CorevistAPI::API
  class BaseController < ActionController::API
    before_action :authenticate_user!
    before_action :prepare_response!

    include ActionController::MimeResponds
    include ActionController::Helpers

    # rescue_from StandardError, with: :handle_exception

    respond_to :json

    helper_method :api_response

    CURRENT_USER_ID_KEY = 'current_user_id'.freeze

    def api_response
      @api_response ||= CorevistAPI::ApiResponse.new
    end

    def params
      return super if current_user.blank?

      super.merge(CURRENT_USER_ID_KEY => current_user.id)
    end

    private

    def prepare_response!
      api_response
    end

    def handle_exception
      render partial: 'corevist_api/api/common/errors', locals: { errors: ['Unexpected exception'] }, status: 500
    end
  end
end
