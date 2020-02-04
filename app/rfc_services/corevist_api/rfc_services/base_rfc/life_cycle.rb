module CorevistAPI
  module RFCServices::BaseRFC::LifeCycle
    protected

    def input
      raise NotImplementedError
    end

    def output
      @sap_return.from_function(@function)
      @measures[:standard_time] = @sap_return.standard_time
      @measures[:sap_time] = @sap_return.sap_time

      if @sap_return.message_type.present?
        raise CorevistAPI::RFCServices::BaseRFC::Error.new(@sap_return)
      end
    end

    def input_encode
      encode_function(@input_encoding)
    end

    def output_encode
      encode_function(@output_encoding)
    end

    def dump_input
      dump_function(:Import)
    end

    def dump_output
      dump_function(:Export)
    end

    def truncate_input
      service_for(:truncate_rfc, @function.parameters, Settings.sap.truncations).call
    end

    def additional_data
      @object&.log.to_s
    end

    def execute_function
      trace_execution_scoped(@func_name) do
        @function.invoke
      end
    end

    def set_connection
      @connection = CorevistAPI::RFCServices::BaseRFC::Connection.instance.open
    end

    def set_function
      @function = CorevistAPI::RFCServices::BaseRFC::Connection.instance.function(@func_name)
    end

    def result
      BaseRFC::Result.new(@sap_return, @data)
    end
  end

end
