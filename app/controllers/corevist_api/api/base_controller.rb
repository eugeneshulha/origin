module CorevistAPI::API
  class BaseController < ActionController::API
    before_action :authenticate_user!
    before_action :set_context

    include ActionController::MimeResponds
    include ActionController::Helpers
    include CorevistAPI::ActionPerformer
    include CorevistAPI::JsonResponse

    # rescue_from StandardError, with: :handle_exception

    respond_to :json

    private

    def set_context
      CorevistAPI::Context.current_user = current_user if current_user
    end

    def handle_exception(exception)
      error("api.errors.#{exception}")
    end
  end
end
