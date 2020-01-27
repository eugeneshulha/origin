module CorevistAPI
  class RFCManager::Connection < SimpleDelegator
    CLOSE_EXCEPTION = 'CONNECTION CLOSE EXCEPTION'.freeze

    def function(name)
      discover(name).new_function_call
    end

    def close
      __getobj__.close
    rescue Exception => exc
      Rails.logger.tagged(CLOSE_EXCEPTION) do
        log_error(exc)
      end
    end

    private

    def log_error(exc)
      Rails.logger.error(exc.message)

      if exc.respond_to?(:error)
        Rails.logger.error { exc.error.inspect }
      end
    end
  end
end
