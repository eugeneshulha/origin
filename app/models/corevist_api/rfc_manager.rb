require 'new_relic/agent/method_tracer'
require 'sapnwrfc' unless (Rails.env.to_s == 'test' || ENV['SET_MOCKS_ACTIVE'] == 'true')
module CocrevistAPI
  class RFCManager
    include Singleton
    include NewRelic::Agent::MethodTracer

    COMMUNICATION_FAILURES = %w[
    RFC_COMMUNICATION_FAILURE
    RFC_INVALID_PARAMETER
    LOAD_PROGRAM_LOST
    TYPELOAD_NEW_VERSION
    TYPELOAD_LOST
    CALL_FUNCTION_REMOTE_ERROR
    LOAD_TYPE_VERSION_MISMATCH
    DDIC_TYPE_INCONSISTENCY
    RFC_CONVERSION_FAILURE
  ].freeze

    SAP_TIME_CALCULATION_RANGES = {
        3600 => 0..1,
        60 => 2..3,
        1 => 4..5
    }.freeze

    CONNECTION_CONFIG = %w[ashost sysnr client user passwd lang loglevel trace].freeze
    CONNECTION_OPENING_FAILED_MSG = 'RFC connection open failed'.freeze
    SAP_DOWN_MSG = 'SAP_DOWN'.freeze
    RFC_EXCEPTION_MSG = 'RFC EXCEPTION'.freeze
    EXECUTION_RESULTS_TAG = 'EXECUTION RESULTS'.freeze
    DEFAULT_LOG_LEVEL = 'WARN'.freeze

    #def self.method_missing(name, *args)
    #  return super unless instance.respond_to?(name)
    #  instance.send(name, *args)
    #end

    def initialize
      @app_log = nil
      @array_log = nil
      @connection = nil
      @retry_attempts = 0
      @max_retries = 1
      @time_metrics = {}
      @pre_encoding = Encoding::ASCII_8BIT
      @post_encoding = Encoding::UTF_8
    end

    def connection
      check_connection
      @connection
    end

    def populate_rfc_sap_return(rfc)
      sap_return = SapReturn.new
      sap_return.message_type = rfc.parameters['SAP_RETURN'].value['TYPE'].strip
      sap_return.id = rfc.parameters['SAP_RETURN'].value['ID'].strip
      sap_return.number = rfc.parameters['SAP_RETURN'].value['NR']
      sap_return.message = rfc.parameters['SAP_RETURN'].value['MSG'].strip
      sap_return.message_v1 = rfc.parameters['SAP_RETURN'].value['MSGV1'].strip
      sap_return.message_v2 = rfc.parameters['SAP_RETURN'].value['MSGV2'].strip
      sap_return.message_v3 = rfc.parameters['SAP_RETURN'].value['MSGV3'].strip
      sap_return.message_v4 = rfc.parameters['SAP_RETURN'].value['MSGV4'].strip
      sap_return.rfc_name = rfc.name
      sap_return.app_server = rfc.parameters['SAP_RETURN'].value['APP_SERVER'].strip if rfc.parameters['SAP_RETURN'].value['APP_SERVER']
      sap_return.sap_time = calculate_rfc_time(rfc.parameters['SAP_RETURN'].value['START_TIME'], rfc.parameters['SAP_RETURN'].value['END_TIME'])
      sap_return
    end

    def process_rfc_output_addresses(addresses)
      addr = {}
      addresses.each do |a|
        number = a['NR'].drop_leading_zeros
        unless addr[number]
          addr[number] = []
        end
        addr[number] << a['LINE'].strip
      end
      addr
    end

    def dump_user_input_data(rfc)
      key_line = "USER_DATA: |#{rfc.parameters['USER_DATA'].value.keys.join('|')}|"

      self.deep_strip rfc.parameters['USER_DATA'].value.values
      line = to_line rfc.parameters['USER_DATA'].value.values
      line = "  #{line}"

      if @app_log
        Rails.logger.info "#{key_line}\n"
        Rails.logger.info "#{line}\n"
      end
      if @array_log
        Const::App.rfc_log << key_line
        Const::App.rfc_log << line
      end
      if rfc.parameters['ASSIGNED_SOLD_TOS'] and rfc.parameters['ASSIGNED_SOLD_TOS'].value
        Rails.logger.info "ASSIGNED_SOLD_TOS:\n" if @app_log
        Const::App.rfc_log << "ASSIGNED_SOLD_TOS:" if @array_log
        rfc.parameters['ASSIGNED_SOLD_TOS'].value.each_with_index do |sold_to, index|
          #RPM add to dump column names
          if index == 0
            line = "no-column-headings"
            line = "  |#{sold_to.keys.join('|')}|" if sold_to && sold_to.keys
            Rails.logger.info "#{line}\n" if @app_log
            Const::App.rfc_log << line if @array_log
          end

          self.deep_strip sold_to.values
          line = to_line sold_to.values
          line = "  #{index}: #{line}"

          Rails.logger.info "#{line}\n" if @app_log
          Const::App.rfc_log << line if @array_log
        end
      end
      if rfc.parameters['ASSIGNED_SHIP_TOS'] and rfc.parameters['ASSIGNED_SHIP_TOS'].value
        Rails.logger.info "ASSIGNED_SHIP_TOS:\n" if @app_log
        Const::App.rfc_log << "ASSIGNED_SHIP_TOS:" if @array_log
        rfc.parameters['ASSIGNED_SHIP_TOS'].value.each_with_index do |ship_to, index|
          if index == 0
            line = "  |#{ship_to.keys.join('|')}|"
            Rails.logger.info "#{line}\n" if @app_log
            Const::App.rfc_log << line if @array_log
          end

          self.deep_strip ship_to.values
          line = to_line ship_to.values
          line = "  #{index}: #{line}"

          Rails.logger.info "#{line}\n" if @app_log
          Const::App.rfc_log << line if @array_log
        end
      end
      if rfc.parameters['ASSIGNED_PAYERS'] and rfc.parameters['ASSIGNED_PAYERS'].value
        Rails.logger.info "ASSIGNED_PAYERS:\n" if @app_log
        Const::App.rfc_log << "ASSIGNED_PAYERS:" if @array_log
        rfc.parameters['ASSIGNED_PAYERS'].value.each_with_index do |payer, index|
          if index == 0
            line = "  |#{payer.keys.join('|')}|"
            Rails.logger.info "#{line}\n" if @app_log
            Const::App.rfc_log << line if @array_log
          end

          self.deep_strip payer.values
          line = to_line payer.values
          line = "  #{index}: #{line}"

          Rails.logger.info "#{line}\n" if @app_log
          Const::App.rfc_log << line if @array_log
        end
      end
      if rfc.parameters['ASSIGNED_TERRITORIES'] and rfc.parameters['ASSIGNED_TERRITORIES'].value
        Rails.logger.info "ASSIGNED_TERRITORIES:\n" if @app_log
        Const::App.rfc_log << "ASSIGNED_TERRITORIES:" if @array_log
        rfc.parameters['ASSIGNED_TERRITORIES'].value.each_with_index do |terr, index|
          if index == 0
            line = "  |#{terr.keys.join('|')}|"
            Rails.logger.info "#{line}\n" if @app_log
            Const::App.rfc_log << line if @array_log
          end

          self.deep_strip terr.values
          line = to_line terr.values
          line = "  #{index}: #{line}"

          Rails.logger.info "#{line}\n" if @app_log
          Const::App.rfc_log << line if @array_log
        end
      end

      if rfc.parameters['ASSIGNED_SALES_AREAS'] and rfc.parameters['ASSIGNED_SALES_AREAS'].value
        Rails.logger.info "ASSIGNED_SALES_AREAS:\n" if @app_log
        Const::App.rfc_log << "ASSIGNED_SALES_AREAS:" if @array_log
        rfc.parameters['ASSIGNED_SALES_AREAS'].value.each_with_index do |sa, index|
          if index == 0
            line = "  |#{sa.keys.join('|')}|"
            Rails.logger.info "#{line}\n" if @app_log
            Const::App.rfc_log << line if @array_log
          end

          self.deep_strip sa.values
          line = to_line sa.values
          line = "  #{index}: #{line}"

          Rails.logger.info "#{line}\n" if @app_log
          Const::App.rfc_log << line if @array_log
        end
      end
    end

    def dump_partner_cache_data(rfc)
      dump_table(rfc, 'PARTNERS')
      dump_table(rfc, 'TEXTS') #E37
      dump_table(rfc, 'PARTNERS_SALES_DATA')
      if rfc.parameters['FUNCTIONS_PARTNERS']
        dump_table(rfc, 'FUNCTIONS_PARTNERS')
      end
      dump_table(rfc, 'POSTAL_ADDRESSES')
      dump_table(rfc, 'STREET_ADDRESSES')
    end

    def dump_heading(rfc, string)
      line = "#{Const::App.rfc_id} #{Time.now.to_s(:db)}: #{string}"
      Rails.logger.info "#{line}\n" if @app_log
      Const::App.rfc_log << line if @array_log
    end

    def dump_string(string)
      Rails.logger.info "#{string}\n" if @app_log
      Const::App.rfc_log << "#{string}" if @array_log
    end

    def dump_field(rfc, field)
      line = "#{field}: #{rfc.parameters[field].value.strip}"
      Rails.logger.info "#{line}\n" if @app_log
      Const::App.rfc_log << line if @array_log
    end

    def dump_structure(rfc, structure)
      return true unless (rfc.parameters[structure] and rfc.parameters[structure].value)
      self.deep_strip rfc.parameters[structure].value.values
      line = to_line rfc.parameters[structure].value.values
      line = "  #{line}"

      if @app_log
        Rails.logger.info "#{structure}: |#{rfc.parameters[structure].value.keys.join('|')}|\n"
        Rails.logger.info "#{line}\n"
      end
      if @array_log
        Const::App.rfc_log << "#{structure}: |#{rfc.parameters[structure].value.keys.join('|')}|"
        Const::App.rfc_log << line
      end
    end

    def dump_table(rfc, table, strip = true)
      if rfc.parameters[table] && rfc.parameters[table].value
        Rails.logger.info "#{table}:\n" if @app_log
        Const::App.rfc_log << "#{table}:" if @array_log

        rfc.parameters[table].value.each_with_index do |i, index|
          if index == 0
            line = "  |#{i.keys.join('|')}|"
            Rails.logger.info "#{line}\n" if @app_log
            Const::App.rfc_log << line if @array_log
          end

          if strip
            self.deep_strip i.values
          end

          #RPM20150420: strange errors in the logs indicate line cannot be written due to ASCII-8 conversion
          #See Apr 20 14:56:21 blount-r3-qa in papertrail  "log writing failed. "\xC2" from ASCII-8BIT"
          if i and i.values and index
            line = "  #{index}: #{i.values.join('|')}|"
            line = line.force_encoding("utf-8")

            Rails.logger.info "#{line}\n" if @app_log
            Const::App.rfc_log << line if @array_log
          end
        end
      end
    end

    def populate_rfc_price_components(rfc, header)
      price_components = {}
      cond_types = {}
      header.price_components = []
      rfc.parameters['PRICE_COMPONENTS'].value.each do |row|
        RFCManager.deep_strip row.values

        r = PriceComponent.new
        r.item_number = row['ITEM_NR'].drop_leading_zeros
        r.cond_type = row['COND_TYPE']
        r.per = row['PER'].to_i
        r.unit = row['UNIT']
        r.calc_type = row['CALCT']
        r.rate = Amount.new(row['RATE'].sap_amnt_to_i, row['RUNIT'])
        r.value = Amount.new(row['VALUE'].sap_amnt_to_i, header.currency.strip)
        # add it to the hash
        if r.item_number == '0'
          header.total_value = r.value if r.cond_type == '&TOT'
          header.price_components << r
        else
          unless price_components[r.item_number]
            price_components[r.item_number] = []
          end
          price_components[r.item_number] << r
        end
      end
      rfc.parameters['COND_TYPES'].value.each do |row|
        cond_types[row['COND_TYPE']] = row['TXT']
      end
      return price_components, cond_types
    end

    def populate_rfc_doc_texts(rfc, header, items)
      # convert texts from SAP format
      header.texts = {}
      item_texts = {}
      # currently assumes that all texts are in one language (or only one text per language)
      header_id = nil
      item_id = nil
      item_number = nil
      rfc.parameters['TEXTS'].value.each do |text|
        text_item_number = text['ITEM_NR'].drop_leading_zeros
        if text_item_number == '0' # header texts
          unless text['TEXT_ID'] == header_id
            header_id = text['TEXT_ID']
            header.texts[header_id] = ''
          end
          add_rfc_text_line(text, header.texts)
        else # item texts (temp.hash)
          unless text_item_number == item_number
            item_id = nil
            item_number = text_item_number
            item_texts[item_number] = {}
          end
          unless text['TEXT_ID'] == item_id
            item_id = text['TEXT_ID']
            item_texts[item_number][item_id] = ''
          end
          add_rfc_text_line(text, item_texts[item_number])
        end
      end
      # add temp hash to the items
      items.each do |item|
        item.texts ||= {}
        if item.respond_to?(:ext_item_number) && item_texts[item.ext_item_number]
          item.texts.merge!(item_texts[item.ext_item_number])
        elsif item_texts[item.item_number]
          item.texts = item_texts[item.item_number]
        end
      end
    end

    def process_partner_texts(texts) #E37
      if texts
        general_texts = {}
        sales_texts = {}
        texts.each do |text_line|
          nr = text_line['NR'].drop_leading_zeros
          if text_line['SA'].blank?
            general_texts[nr] = {} unless general_texts[nr]
            general_texts[nr][text_line['TEXT_ID']] = '' unless general_texts[nr][text_line['TEXT_ID']]
            add_rfc_text_line(text_line, general_texts[nr])
          else
            sales_texts[nr] = {} unless sales_texts[nr]
            sales_texts[nr][text_line['SA']] = {} unless sales_texts[nr][text_line['SA']]
            sales_texts[nr][text_line['SA']][text_line['TEXT_ID']] = '' unless sales_texts[nr][text_line['SA']][text_line['TEXT_ID']]
            add_rfc_text_line(text_line, sales_texts[nr][text_line['SA']])
          end
        end #do
      end #if

      return general_texts, sales_texts
    end

    def execute(object, method, app_log = true, array_log = false)
      set_execute_locals(app_log, array_log)
      clear_execute_constants

      with_exception_handling(object, execute_retry_condition) do
        @time_metrics[:start_time] = Time.now
        @rfc_name = get_rfc_name(method)
        set_rfc_id
        check_connection
        @time_metrics[:conn_time] = Time.now

        with_tagged_logger(@rfc_name) do
          Rails.logger.info("ID: #{Const::App.rfc_id}")
          trace_execution_scoped(["Custom/SAP/discover_RFC: #{@rfc_name} - ID: #{Const::App.rfc_id}"]) do
            @function = @connection.function(@rfc_name)
          end

          @time_metrics[:disc_time] = Time.now
          object.send("#{method}_rfc_input", @function)
          ServiceFactory.instance.for(:truncate_rfc, @function.parameters, Settings.sap.truncations).call

          encode_function(@function, @pre_encoding)
          @time_metrics[:inp_time] = Time.now

          trace_execution_scoped(["Custom/SAP/invoke_RFC: #{@rfc_name} - ID: #{Const::App.rfc_id}"]) do
            @function.invoke
          end

          @time_metrics[:call_time] = Time.now
          @time_metrics[:standard_time] = @function.parameters['SAP_RETURN'].value['STANDARD_TIME']
          encode_function(@function, @post_encoding)
          object.send("#{method}_rfc_output", @function)
          @time_metrics[:outp_time] = Time.now
        end
      end
    end

    def provide_connection_details
      begin
        "#{@connection.connection_attributes.inspect}"
      rescue => exc
        raise exc
      end
    end

    def ping_sap
      start_time = Time.now
      ping_id = 'P' + sprintf("%09d", rand(999999999)) # P + 9digit random number
      ok_to_retry = true

      begin
        check_connection
        @connection.ping
        Const::App.rfc_failures = nil
        mongrel_log('PING_SAP', ping_id, Time.now - start_time)
        'ok'
      rescue SAPNW::RFC::FunctionCallException, SAPNW::RFC::ConnectionException => exc
        error_log('PING_SAP_EXCEPTION', exc, ping_id)
        if @connection
          begin
            @connection.close
          rescue Exception => e
            rfc_communication_failure = true
            error_log("PING_SAP_CLOSE_EXCEPTION", e, ping_id)
          ensure
            @connection = nil # to be sure it is nil
          end
        end
        if !(exc.error['error'] =~ /^RFC connection open failed/) and
            # if there is no connectivity: we get the error 'RFC connection open failed', in which case there's no point to try again,
            # it just blocks mongrel for another 20s
            exc.error['key'] =~ /^RFC_COMMUNICATION_FAILURE|^RFC_INVALID_PARAMETER|^LOAD_PROGRAM_LOST|^TYPELOAD_NEW_VERSION|^TYPELOAD_LOST|^CALL_FUNCTION_REMOTE_ERROR|^LOAD_TYPE_VERSION_MISMATCH|^DDIC_TYPE_INCONSISTENCY/
          # We can retry under these circumstances:
          # 1. if the connection was dropped on the SAP side, we get a FunctionCallException or a ConnectionException with the key
          #    RFC_COMMUNICATION_FAILURE or sometimes RFC_INVALID_PARAMETER
          # 2. if a transport affected the called program (e.g. Program Z_SD_RVADOR01 was modified during the run), key: LOAD_PROGRAM_LOST.
          rfc_communication_failure = true
        end
        if ok_to_retry and rfc_communication_failure
          ok_to_retry = false
          retry
        else
          log_rfc_failure if Const::App.configs[:mongrel_monitor] and !Const::App.sap_down_till # so the ping does not increase the number of failures during down-times
          r = RfcException.new
          r.info = {}
          r.info[:id] = ping_id
          r.info[:class] = exc.class
          r.info[:message] = exc.error['message']
          r.info[:key] = exc.error['key']
          r.info[:code] = exc.error['code']
          r.info[:error] = exc.error['error']
          raise r
        end
      end
    end

    def deep_strip(object)
      return(object) unless [Array, Hash, String].include?(object.class)

      if object.is_a?(String)
        object = object.strip if object.frozen?
        object.strip!
        return object
      end

      if object.is_a?(Hash)
        keys = object.keys.clone

        keys.each do |k|
          new_key = deep_strip(k)
          value = object.delete k
          object[new_key] = value
        end
      end

      if object.is_a?(Enumerable)
        object.each { |i| deep_strip i }
      end
    end

    def function_param(function, param_name)
      param_name = param_name.to_s.upcase

      if function.parameters[param_name].blank?
        return Hash.new
      end

      function.parameters[param_name].value
    end

    def execute_retry_condition
      lambda do |exception|
        @retry_attempts += 1
        condition_met = !exception.error['error'].start_with?(CONNECTION_OPENING_FAILED_MSG) &&
            COMMUNICATION_FAILURES.any? { |msg| exception.error['key'].start_with?(msg) }

        condition_met and @retry_attempts <= @max_retries
      end
    end

    private

    def check_connection
      if @connection.blank? || config_changed?
        establish_connection
      end
    end

    def config_changed?
      SAPNW::Base.config != SiteSetting.rfc_config
    end

    def get_rfc_name(method)
      #Backwards compatible names will include Z_B2B_SALESDOC_DISPLAY_3
      #New namespace /COREVIST/SALESDOC_DISPLAY has no version number
      rfc_name = "#{Const::App.configs[:rfc_prefix]}#{Const::App.configs[:RFCs][method]}"
      if Const::App.configs[:RFC_version]
        unless rfc_name =~ /\d+$/ || Const::App.configs[:RFCs][:without_version].include?(method)
          rfc_name = "#{rfc_name}_#{Const::App.configs[:RFC_version]}"
        end
      end
      rfc_name
    end

    def set_execute_locals(app_log, array_log)
      @app_log = app_log
      @array_log = array_log
    end

    def clear_execute_locals
      Const::App.rfc_failures = nil
      @time_metrics = {}
      @interface = nil
      @function = nil
      @rfc_name = nil
      @retry_attempts = 0
    end

    def clear_execute_constants
      Const::App.rfc_log = []
      Const::App.messages = []
    end

    def set_rfc_id
      if Const::App.ws_id
        Const::App.rfc_id = Const::App.ws_id
      else
        Const::App.rfc_id = sprintf("%010d", rand(9999999999)) # 10-digit random number
      end
    end

    def time_diff(from, to)
      @time_metrics.fetch(from, 0).to_f - @time_metrics.fetch(to, 0).to_f
    end

    def try_write_log
      return unless @app_log
      yield
    end

    def set_rfc_config
      config = SiteSetting.rfc_config
      SAPNW::Base.config = CONNECTION_CONFIG.inject({}) do |memo, name|
        memo[name] = config[name]
        memo
      end
    end

    def establish_connection
      set_rfc_config
      trace_execution_scoped(['Custom/SAP/init_rfc_connection']) do
        @connection = Connection.new(SAPNW::Base.rfc_connect)
      end

      try_write_log do
        log_new_connection('RFC_NEW_CONNECTION', Const::App.rfc_id, Time.now - @time_metrics.fetch(:start_time, 0))
      end

      Const::App.sap_system = @connection.connection_attributes['sysId']
      Const::App.sap_server = @connection.connection_attributes['partnerHost']
    end

    def handle_blank_rfc_params(rfc)
      rfc.parameters.each do |parameter, value|
        if parameter =~ /_IN$/ or value.direction == 1
          if value.value.is_a?(Hash)
            check_for_nils(value.value)
          elsif value.value.is_a?(Array)
            value.value.each_with_index do |hash, index|
              check_for_nils(hash, index)
            end
          end
        end
      end
    end

    def with_tagged_logger(tag)
      Rails.logger.tagged(tag) do
        yield
      end
    end

    def hash_to_log(hash)
      hash.each do |name, value|
        next if value.blank?
        Rails.logger.error("#{name.to_s.upcase} - #{value}")
      end
    end

    def with_exception_handling(object, retry_condition)
      begin
        yield
        @time_metrics[:sap_time] = object&.sap_return&.sap_time || 0
      rescue SAPNW::RFC::FunctionCallException, SAPNW::RFC::ConnectionException => exc
        try_write_log do
          error_log(RFC_EXCEPTION_MSG, exc, Const::App.rfc_id)
        end
        close_connection
        retry_condition.call(exc) and retry
        error = true
        execute_sap_rescue(exc)
      rescue SapReturn => exc
        error = true
        raise exc
      rescue => exc
        error = true
        raise RfcException, exc
      ensure
        try_write_log do
          ensure_execute_logged(object, error)
        end
        clear_execute_locals
      end
    end

    def execute_sap_rescue(exception)
      if Const::App.configs[:mongrel_monitor]
        log_rfc_failure
      end

      raise RfcException, exception
    end

    def ensure_execute_logged(object, error)
      execution_results = {
          rfc_id: Const::App.rfc_id,
          rfc_func: @function&.name,
          start_time: @time_metrics.fetch(:start_time, Time.now).to_s(:db),
          conn_time: time_diff(:conn_time, :start_time),
          discovery_time: time_diff(:disc_time, :conn_time),
          process_in: time_diff(:inp_time, :disc_time),
          call_time: time_diff(:call_time, :inp_time) - @time_metrics.fetch(:standard_time, 0).to_f,
          standard_time: @time_metrics.fetch(:standard_time, 0).to_f,
          sap_time: @time_metrics.fetch(:sap_time, 0).to_f,
          process_out: time_diff(:outp_time, :call_time),
          sap_total: time_diff(:outp_time, :start_time),
          session_id: Const::App.session_id,
          port_server: "#{Const::App.port}-#{Const::App.server}",
          additional_data: object&.log.to_s,
          error: error
      }

      with_tagged_logger(EXECUTION_RESULTS_TAG) do
        Rails.logger.info { execution_results.inspect }
      end

      ServiceFactory.instance.for(:rfc_log_save, RfcLog.new, function: @function, results: execution_results).call
    end

    def log_rfc_failure
      if Const::App.rfc_failures
        Const::App.rfc_failures[:count] += 1
        if Const::App.rfc_failures[:count] >= Const::App.configs[:mongrel_monitor][:number_of_failures] and
            # so it isn't because SAP is down
            Time.now > Const::App.rfc_failures[:start] + (Const::App.configs[:sap_monitor][:number_of_failures] * 60) + 120
          Rails.logger.info "KILL_MONGREL;#{Time.now.to_s(:db).sub(' ', ';')};failures: #{Const::App.rfc_failures[:count]}; time of first failure: #{Const::App.rfc_failures[:start]};\n\n\n"
          Rails.logger.info "KILL_MONGREL_EXCEPTION;#{Time.now.to_s(:db).sub(' ', ';')};#{Const::App.port}-#{Const::App.server};"
          trigger = File.new("tmp/pids/mongrel.#{Const::App.port}.corrupted", "w")
          trigger.close
        end
      else
        # first failure
        Const::App.rfc_failures = {}
        Const::App.rfc_failures[:count] = 1
        Const::App.rfc_failures[:start] = Time.now
      end
    end

    def encode_function(function, encoding)
      function.parameters.each do |_, structure|
        next if structure.value.nil?
        structure.value = encode_struct(structure.value, encoding)
      end
    end

    def encode_struct(value, encoding)
      send("encode_#{value.class.name.downcase}", value, encoding)
    rescue
      value
    end

    def encode_string(value, encoding)
      value.force_encoding(encoding)
    end

    def encode_array(value, encoding)
      value.map { |v| encode_struct(v, encoding) }
    end

    def encode_hash(value, encoding)
      value.map { |k, v| [k, encode_struct(v, encoding)] }.to_h
    end

    def populate_rfc_log(rfc)
      return nil unless rfc.parameters['LOG'].blank?
      rfc_message_log = []
      rfc.parameters['LOG'].value.each do |row|
        r = OpenItems::BapiMessage.new
        r.message_type = row['TYPE']
        r.id = row['ID']
        r.number = row['NUMBER']
        r.variable1 = row['MESSAGE_V1']
        r.variable2 = row['MESSAGE_V2']
        r.variable3 = row['MESSAGE_V3']
        r.variable4 = row['MESSAGE_V4']
        r.row = row['ROW']
        r.text = row['MESSAGE']
        rfc_message_log << r
      end
      rfc_message_log
    end

    def error_log(title, e, id)
      error_params = {
          rfc_id: id,
          start_time: Time.now.to_s(:db),
          cause: e.class.to_s,
          message: e.message
      }

      if e.respond_to?(:error)
        e.error.each do |key, value|
          error_params[key] = (key == 'message' ? value.gsub!("\n", '-') : value)
        end
      end

      with_tagged_logger(title) do
        hash_to_log(error_params)
      end
    end

    def log_new_connection(title, id, conn_time, disc_time=0)
      connection_params = [
          id,
          Time.now.to_s(:db),
          conn_time,
          disc_time
      ]

      with_tagged_logger(title) do
        Rails.logger.info("#{connection_params.join('/')}")
        Rails.logger.info { @connection.connection_attributes.inspect }
      end
    end

    def mongrel_log(title, id, duration)
      Rails.logger.info "#{title};#{id};#{Time.now.to_s(:db).sub(' ', ';')};#{duration}\n\n"
    end

    def calculate_rfc_time(from, to)
      1.tap do |result|
        SAP_TIME_CALCULATION_RANGES.each do |factor, range|
          result += sap_time_diff(to[range], from[range], factor)
        end
      end
    end

    def sap_time_diff(to, from, factor)
      (to.to_i - from.to_i) * factor
    end

    def check_for_nils(hash, index=nil)
      hash.each do |key, value|
        if value.nil?
          if index
            message = 'problem with the RFC interface population:'\
                    " #{key} is nil (index #{index}), which makes the invoke crash"
            Debug::PrettyData.print(message, level: :error, title: 'RFC EXCEPTION')
            raise "#{key } is nil (index #{index})"
          else
            message = "problem with the RFC interface population: #{key} is nil, which makes the invoke crash"
            Debug::PrettyData.print(message, level: :error, title: 'RFC EXCEPTION')
            raise "#{key } is nil"
          end
        end
      end
    end

    def add_rfc_text_line(sap_text, text) #E37
      if sap_text[Const::App.configs[:text_format_fieldname]].empty? # continuous text
        text[sap_text['TEXT_ID']] << "#{sap_text['LINE']} "
      else # new line, new paragraph or something else (TBD, whether we should distinguish)
        if text[sap_text['TEXT_ID']].empty?
          text[sap_text['TEXT_ID']] << "#{sap_text['LINE']} " # don't start with a line break
        else
          text[sap_text['TEXT_ID']] << "\n#{sap_text['LINE']} "
        end
      end
    end

    def to_line(*values)
      "|#{ Array.wrap(values).flatten.join('|') }|"
    end

    def close_connection
      @connection&.close
    rescue Exception => exc
      try_write_log do
        error_log('CLOSE_EXCEPTION', exc, Const::App.rfc_id)
      end
    ensure
      @connection = nil
    end
  end

end
