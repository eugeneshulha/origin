module CorevistAPI::API
  class BaseController < ActionController::API
    before_action :prepare_response!

    include ActionController::MimeResponds
    include ActionController::Helpers

    respond_to :json

    helper_method :api_response

    def api_response
      @api_response ||= CorevistAPI::ApiResponse.new
    end

    private

      def prepare_response!
        api_response
      end
  end
end
