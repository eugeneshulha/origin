module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class PingService < CorevistAPI::Services::BaseService
      def initialize(*)
        super
        @errors = []
      end

      private

      def perform
        connection = if CorevistAPI::SAPConnection.current&.id.to_s == @params[:uuid]
          CorevistAPI::Context.current_connection
        else
          result = service_for(:connect_to_sap, { uuid: @params[:uuid] }).call
          result.data
        end

        result(status: connection.ping)
      rescue SAPNW::RFC::ConnectionException => e
        result(status: false)
      end
    end
  end
end
