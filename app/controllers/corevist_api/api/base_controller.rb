module CorevistAPI::API
  class BaseController < ActionController::API
    before_action :authenticate_user!, except: [:not_found]
    before_action :set_context

    include ActionController::MimeResponds
    include ActionController::Helpers
    include CorevistAPI::JsonResponse
    include CorevistAPI::ActionPerformer
    include CorevistAPI::ConfigsFor
    include CorevistAPI::Translations::Controller::Base

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
      # TODO: rewrite it. Base exceptions should not be under _('error|...') namespace
      error(_("error|#{exception}"))

      log_exception(exception)
    end

    def handle_service_exception(exception)
      error(exception.message)

      log_exception(exception)
    end

    private

    def log_exception(exception)
      Rails.logger.error "\n"
      Rails.logger.error '-' * 70
      Rails.logger.error exception.message
      Rails.logger.error '-' * 70
      Rails.logger.error exception.backtrace.join("\n")
    end
  end
end
