require 'new_relic/agent/method_tracer'

module CorevistAPI
  module RFCServices
    class BaseRFCService
      include NewRelic::Agent::MethodTracer
      include CorevistAPI::Constants::SAP::Tables
      include CorevistAPI::Constants::SAP::Columns
      include CorevistAPI::RFCServices::BaseRFC::DumpData
      include CorevistAPI::RFCServices::BaseRFC::Conversion
      include CorevistAPI::RFCServices::BaseRFC::LifeCycle
      include CorevistAPI::RFCServices::BaseRFC::WithHelpers

      MAX_RETRIES = 1

      def initialize(object, params = {})
        @object = object
        @params = params&.dup
        @func_name = get_function_name(function_name)
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

      def function_name
        raise NotImplementedError
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

      def get_function_name(method)
        {
          salesdoc_display: '/COREVIST/SALESDOC_DISPLAY',
          salesdoc_list: '/COREVIST/SALESDOC_LIST',
          invoice_display: '/COREVIST/INVOICE_DISPLAY',
          invoice_list: '/COREVIST/INVOICE_LIST',
          partner_search: '/COREVIST/PARTNER_SEARCH',
          get_partner: '/COREVIST/PARTNER_DATA',
          open_items: '/COREVIST/OPEN_ITEMS',
          get_pdf: '/COREVIST/GET_PDF',
          summary: '/COREVIST/SUMMARY',
          pay_bill: '/COREVIST/PAY_BILL'
        }[method]
      end

      def user
        CorevistAPI::Context.current_user
      end
    end
  end
end
