module CorevistAPI::API
  class BaseController < ActionController::API
    before_action :authenticate_user!, except: [:not_found]
    before_action :set_context
    before_action :establish_sap_connection

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

    helper_method :current_connection

    def not_found
      error_404('api.errors.not_found')
    end

    def establish_sap_connection
      return if current_connection&.connection.present?
      check_if_sap_is_down

      service = service_for(:connect_to_sap)
      result = service.call
      CorevistAPI::Context.current_connection = result.data
    rescue SAPNW::RFC::ConnectionException => e
      CorevistAPI::SAPDowntime.create(
          down_from_date: Time.zone.now.to_date,
          down_to_date: Time.zone.now.to_date,
          down_from_time: Time.zone.now.to_time,
          down_to_time: Time.zone.now.to_time + 5.minute,
          active: true)
    end

    def current_connection
      CorevistAPI::Context.current_connection
    end

    private

    def set_context
      CorevistAPI::Context.current_user = current_user if current_user
    end

    def check_if_sap_is_down
      if is_sap_down? && current_user&.not_authorized_for?('login_when_sap_is_down')
        raise CorevistAPI::ServiceException.new('sap is down')
      end
    end

    def handle_exception(exception)
      # TODO: rewrite it. Base exceptions should not be under _('error|...') namespace
      error(_("#{exception}"))

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
