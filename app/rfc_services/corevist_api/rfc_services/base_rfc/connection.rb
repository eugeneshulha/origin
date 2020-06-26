require 'new_relic/agent/method_tracer'
require 'sapnwrfc'

module CorevistAPI
  class RFCServices::BaseRFC::Connection
    include CorevistAPI::RFCServices::BaseRFC::WithHelpers
    include NewRelic::Agent::MethodTracer

    attr_reader :connection

    CLOSE_EXCEPTION = 'CONNECTION CLOSE EXCEPTION'.freeze

    def initialize(configs = {})
      unless CorevistAPI::SAPConnection.current
        CorevistAPI::SAPDowntime.create(
            down_from_date: Time.zone.now.to_date,
            down_to_date: Time.zone.now.to_date,
            down_from_time: Time.zone.now.to_time,
            down_to_time: Time.zone.now.to_time + 5.minute,
            active: true)
      end

      SAPNW::Base.config = configs.presence || CorevistAPI::SAPConnection.current.connection_params
    end

    def open
      return self if !config_changed? && @connection.present?

      trace_execution_scoped(['Custom/SAP/init_rfc_connection']) do
        @connection ||= SAPNW::Base.rfc_connect
      end

      log_new_connection('RFC_NEW_CONNECTION', sprintf("%010d", rand(9999999999)), Time.now - 0)
      self
    end

    def function(name)
      @connection.discover(name).new_function_call
    end

    def ping
      @connection.ping

      log_new_connection('RFC_CONNECTION_PING', sprintf("%010d", rand(9999999999)), Time.now - 0)
    rescue Exception => exc
      Rails.logger.tagged('PING EXCEPTION') do
        log_error(exc)
      end
    end

    def reset_server_context
      @connection.handle&.reset_server_context

    rescue Exception => exc
      Rails.logger.tagged('RESET SERVER CONTEXT EXCEPTION') do
        log_error(exc)
      end
    end

    def close
      @connection.close
      @connection = nil
    rescue Exception => exc
      Rails.logger.tagged(CLOSE_EXCEPTION) do
        log_error(exc)
      end
    end

    def config_changed?
      rfc_config = CorevistAPI::SAPConnection.current.connection_params
      rfc_config.keys.any? { |field| rfc_config[field] != SAPNW::Base.config[field].to_s }
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
