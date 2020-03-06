module CorevistAPI
  module JsonResponse
    extend ActiveSupport::Concern

    STATUSES = {
      200 => :message,
      401 => :error,
      404 => :error,
      500 => :error
    }.freeze

    included do
      def error(error_or_errors, data = nil)
        json(error_or_errors, 500, data)
      end

      def error_401(error_or_errors, data = nil)
        json(error_or_errors, 401, data)
      end

      def error_404(error_or_errors, data = nil)
        json(error_or_errors, 404, data)
      end

      def success(info_or_infos, data = nil)
        json(info_or_infos, 200, data)
      end

      private

      def json(msg, _status, data = nil)
        response = msg.respond_to?(:each) ? msg : I18n.t(msg)
        payload = { status: _status, status(_status).to_s.pluralize => Array.wrap(response) }
        payload.merge!(data: data) if data.present?
        render json: payload, status: _status
      end

      def status(type)
        STATUSES[type]
      end
    end
  end
end
