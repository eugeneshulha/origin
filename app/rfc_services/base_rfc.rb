class BaseRfc
  include NewRelic::Agent::MethodTracer
  include FactoryInterface
  include Sap::Tables
  include Sap::Columns
  include DumpData
  include Conversion
  include LifeCycle
  include WithHelpers

  MAX_RETRIES = 1

  def initialize(object, method, options = {})
    @object = object
    @func_name = func_name(method)
    @logger = Rails.logger
    @measures = Hash.new(0.0)
    @sap_return = Sap::Return.new
    @retry_attempts = 0
    @max_retries = MAX_RETRIES
    @retry_condition = options.fetch(:retry_cond, RFCManager.instance.execute_retry_condition)
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
    func_name = "#{Const::App.configs[:rfc_prefix]}#{Const::App.configs[:RFCs][method]}"
    return func_name if func_name =~ /\d+$/

    need_version = Const::App.configs[:RFC_version].present? && Const::App.configs[:RFCs][:without_version].include?(method)
    need_version ? "#{func_name}_#{Const::App.configs[:RFC_version]}" : func_name
  end

  def raise_rfc_exception(exc)
    @error = true
    raise RfcException, exc
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
