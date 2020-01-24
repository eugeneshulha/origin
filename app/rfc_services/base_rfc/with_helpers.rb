module BaseRfc::WithHelpers
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
    yield
  rescue SAPNW::RFC::FunctionCallException, SAPNW::RFC::ConnectionException => exc
    @connection&.close
    @retry_condition.call(exc) and retry
    log_rfc_exception(exc)
    raise_rfc_exception(exc)
  rescue Sap::Error => exc
    raise_sap_error(exc)
  rescue => exc
    raise_rfc_exception(exc)
  ensure
    execution_log
  end
end
