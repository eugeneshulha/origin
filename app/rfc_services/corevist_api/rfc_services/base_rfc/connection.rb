require 'new_relic/agent/method_tracer'
require 'sapnwrfc'

module CorevistAPI
  class RFCServices::BaseRFC::Connection
    include Singleton
    include CorevistAPI::RFCServices::BaseRFC::WithHelpers
    include NewRelic::Agent::MethodTracer

    attr_reader :connection

    CLOSE_EXCEPTION = 'CONNECTION CLOSE EXCEPTION'.freeze

    def initialize
      # SAPNW::Base.config = conn.as_json.with_indifferent_access
      SAPNW::Base.config = {
          :ashost => "172.20.3.2",
          :sysnr => "00",
          :client => "400",
          :user => "core_cpic",
          :passwd => "b2b4you",
          :lang => 'EN',
          :trace => 0
      }.with_indifferent_access
    end

    def open
      return @connection if @connection.present?

      trace_execution_scoped(['Custom/SAP/init_rfc_connection']) do
        @connection ||= SAPNW::Base.rfc_connect
      end

      log_new_connection('RFC_NEW_CONNECTION', sprintf("%010d", rand(9999999999)), Time.now - 0)
    end

    def function(name)
      @connection.discover(name).new_function_call
    end

    def close
      @connection.close
      @connection = nil
    rescue Exception => exc
      Rails.logger.tagged(CLOSE_EXCEPTION) do
        log_error(exc)
      end
    end

    private

    def log_new_connection(title, id, conn_time, disc_time=0)
      connection_params = [
          id,
          Time.now.to_s(:db),
          conn_time,
          disc_time
      ]

      Rails.logger.tagged(title) do
        Rails.logger.info("#{connection_params.join('/')}")
        Rails.logger.info { @connection.connection_attributes.inspect }
      end
    end

    def log_error(exc)
      Rails.logger.error(exc.message)

      if exc.respond_to?(:error)
        Rails.logger.error { exc.error.inspect }
      end
    end
  end
end
