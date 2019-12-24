module CorevistAPI
  class ApplicationController < ActionController::API
    include ActionController::MimeResponds
    include ActionController::Helpers

    respond_to :json

    before_action :prepare_response!

    helper_method :api_response

    def api_response
      @api_response ||= ApiResponse.new
    end

    private

      def prepare_response!
        api_response
      end
  end
end
