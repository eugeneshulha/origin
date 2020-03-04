module CorevistAPI::API
  class BaseController < ActionController::API
    before_action :authenticate_user!, except: [:not_found]
    before_action :set_context

    include ActionController::MimeResponds
    include ActionController::Helpers
    include CorevistAPI::ActionPerformer
    include CorevistAPI::JsonResponse

    rescue_from StandardError, with: :handle_exception
    rescue_from CorevistAPI::ServiceException, with: :handle_service_exception
    rescue_from ActionController::RoutingError, with: :not_found

    respond_to :json

    def not_found
      error_404('api.errors.not_found')
    end

    private

    def set_context
      CorevistAPI::Context.current_user = current_user if current_user
    end

    def handle_exception(exception)
      error("api.errors.#{exception}")

      Rails.logger.error do
        exception.message
        exception.backtrace.join("\n")
      end
    end

    def handle_service_exception(exception)
      error(exception.messages)
    end
  end
end
