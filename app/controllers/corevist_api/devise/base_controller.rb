module CorevistAPI
  class Devise::BaseController < ActionController::Base
    protect_from_forgery if: :json_request # return null session when API call
    protect_from_forgery with: :exception, unless: :json_request

    helper_method :api_response

    def api_response
      @api_response ||= ApiResponse.new
    end

    private

      def json_request
        request.format.json?
      end

      def prepare_response!
        api_response
      end
  end
end
