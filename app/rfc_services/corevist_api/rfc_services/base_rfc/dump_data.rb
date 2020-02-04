module CorevistAPI
  module RFCServices::BaseRFC::DumpData
    PADSTR = ' '.freeze
    NEXT_INDENT = 2
    DEFAULT_INDENT = 0
    OPERATION_SEPARATOR = '----------------------------------------------'.freeze
    LOG_DATA = '%s;'.freeze
    OUTPUT_FORMAT = '%s: %s'.freeze
    EXECUTION_RESULTS_TAG = 'EXECUTION RESULTS'.freeze
    RFC_EXCEPTION_TAG = 'RFC_EXCEPTION'.freeze

    protected

    def dump_function(operation)
      dump_string(operation, OPERATION_SEPARATOR, DEFAULT_INDENT)
      add_new_line

      @function.parameters.each_key do |key|
        value = @function.parameters[key].value
        next if value.blank?

        dump_struct(key, value)
      end

      add_new_line
    end

    def dump_struct(key, struct, indent = DEFAULT_INDENT)
      send("dump_#{struct.class.name.underscore}", key, struct, indent)
    rescue
      dump_string(key, struct, indent)
    end

    def dump_array(key, array, indent)
      dump_heading(key, indent, array.size)

      array.each_with_index do |el, index|
        dump_string(index, nil, indent + NEXT_INDENT)
        dump_struct(key, el, indent + NEXT_INDENT)
      end
    end

    def dump_hash(key, hash, indent)
      dump_heading(key, indent)

      hash.each do |hash_key, value|
        dump_struct(hash_key, value, indent + NEXT_INDENT)
      end
    end

    def dump_heading(heading, indent, size = nil)
      return if indent > 0
      dump_string(heading, size, indent)
    end

    def dump_string(key, string, indent)
      output = OUTPUT_FORMAT % [key, string.to_s.strip]
      add_new_line(output.rjust(output.length + indent, PADSTR))
    end

    def add_new_line(line = nil)
      @logger.debug(line)
    end

    def data_to_log(object, method_chains)
      output = ''

      method_chains.each do |chain|
        output << "#{send("#{chain.class.name.underscore}_chain_log", object, chain)}"
      end

      output
    end

    def hash_chain_log(object, chain)
      output = ''

      chain.each do |method, deep_chain|
        deep_chain.each do |chained_method|
          output << send("#{chained_method.class.name.underscore}_chained_method", object, method, chained_method)
        end
      end

      output
    end

    def symbol_chain_log(object, chain)
      object.send(chain)
    end

    def hash_chained_method(object, method, chain)
      hash_chain_log(object.send(method), chain)
    end

    def symbol_chained_method(object, method, chained_method)
      LOG_DATA % object.send(method).send(chained_method)
    end

    def log_rfc_exception(exc)
      with_tagged_logging(RFC_EXCEPTION_TAG) do
        exc.error.each do |name, value|
          @logger.error("#{name.upcase}: #{value}")
        end
      end
    end
  end
end
