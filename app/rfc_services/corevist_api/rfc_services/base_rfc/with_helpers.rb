module CorevistAPI
  module RFCServices::BaseRFC::WithHelpers
    protected

    def with_benchmark(measure_name)
      benchmark = Benchmark.measure do
        yield
      end

      @measures[measure_name] = benchmark.real
    end

    def with_tagged_logging(tag = @func_name)
      @logger.tagged(tag) do
        yield
      end
    end

    def with_exception_handling
      attempts ||= 0
      yield
    rescue SAPNW::RFC::FunctionCallException, SAPNW::RFC::ConnectionException => exc
      CorevistAPI::RFCServices::BaseRFC::Connection.instance.close
      log_rfc_exception(exc)

      attempts < 1 ? (attempts += 1) && retry : raise_rfc_exception(exc)
    rescue CorevistAPI::RFCServices::BaseRFC::Error => exc
      raise_sap_error(exc)
    rescue => exc
      raise_rfc_exception(exc)
    end
  end

end
