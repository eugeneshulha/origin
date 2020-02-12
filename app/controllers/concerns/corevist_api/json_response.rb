module CorevistAPI
  module JsonResponse
    extend ActiveSupport::Concern

    STATUSES = {
      info: 200,
      error: 500
    }.freeze

    included do
      def error(error_or_errors, data = nil)
        json(error_or_errors, :error, data)
      end

      def success(info_or_infos, data = nil)
        json(info_or_infos, :info, data)
      end

      private

      def json(msg, type, data = nil)
        response = msg.respond_to?(:each) ? msg : I18n.t(msg)
        payload = { status: status(type), type.to_s.pluralize => Array.wrap(response) }
        payload.merge!(data: data) if data.present?
        render(json: payload, status: status(type))
      end

      def status(type)
        STATUSES[type]
      end
    end
  end
end
