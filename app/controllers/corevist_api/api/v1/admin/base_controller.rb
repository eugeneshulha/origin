module CorevistAPI
  module API
    class V1::Admin::BaseController < BaseController
      include Pundit

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      private

      def user_not_authorized
        api_response.unauthorized!
        api_response.set_message(:api, :unauthorized)
        render(json: api_response)
      end
    end
  end
end
