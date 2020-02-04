require 'new_relic/agent/method_tracer'

module CorevistAPI
  class RFCServices::BaseRFC
    include NewRelic::Agent::MethodTracer
    include CorevistAPI::Constants::SAP::Tables
    include CorevistAPI::Constants::SAP::Columns
    include CorevistAPI::RFCServices::BaseRFC::DumpData
    include CorevistAPI::RFCServices::BaseRFC::Conversion
    include CorevistAPI::RFCServices::BaseRFC::LifeCycle
    include CorevistAPI::RFCServices::BaseRFC::WithHelpers

    MAX_RETRIES = 1

    def initialize(object, method, options = {})
      @object = object
      @func_name = func_name(method)
      @logger = Rails.logger
      @measures = Hash.new(0.0)
      @sap_return = CorevistAPI::RFCServices::BaseRFC::Return.new
      @retry_attempts = 0
      @max_retries = MAX_RETRIES
      @retry_condition = nil
      @error = false
      @data = {}
      @converters = {}
      @input_encoding = Encoding::ASCII_8BIT
      @output_encoding = Encoding::UTF_8
    end

    def call
      @measures[:start_time] = Time.now

      with_exception_handling do
        with_benchmark(:conn_time) do
          set_connection
        end

        with_tagged_logging do
          with_benchmark(:disc_time) do
            set_function
          end

          with_benchmark(:inp_time) do
            input
            truncate_input
            input_encode
            dump_input
          end

          with_benchmark(:call_time) do
            execute_function
          end

          with_benchmark(:outp_time) do
            dump_output
            output
            output_encode
          end
        end
      end

      result
    end

    private

    def func_name(method)
      func_name = "/COREVIST/SALESDOC_DISPLAY"
    end

    def raise_rfc_exception(exc)
      @error = true
      raise CorevistAPI::RfcException, exc
    end

    def raise_sap_error(exc)
      @error = true
      raise exc
    end

    def convert(name, value)
      if (converter = @converters[name]).present?
        return converter.call(value)
      end

      value
    end
  end
end
