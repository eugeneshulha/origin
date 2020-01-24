class Sap::Return
  SAP_RETURN = 'SAP_RETURN'.freeze
  TYPE = 'TYPE'.freeze
  ID = 'ID'.freeze
  NR = 'NR'.freeze
  MSG = 'MSG'.freeze
  MSGV1 = 'MSGV1'.freeze
  MSGV2 = 'MSGV2'.freeze
  MSGV3 = 'MSGV3'.freeze
  MSGV4 = 'MSGV4'.freeze
  APP_SERVER = 'APP_SERVER'.freeze
  START_TIME = 'START_TIME'.freeze
  END_TIME = 'END_TIME'.freeze
  STANDARD_TIME = 'STANDARD_TIME'.freeze

  OVERFLOW = :overflow

  SAP_TIME_CALCULATION_RANGES = {
    3600 => 0..1,
    60 => 2..3,
    1 => 4..5
  }.freeze

  attr_accessor :message_type, :id, :number, :message, :start_time, :end_time, :rfc_name,
                :message_v1, :message_v2, :message_v3, :message_v4, :sap_time, :app_server, :standard_time

  def from_function(function)
    rfc_sap_return = function.parameters[SAP_RETURN]
    @message_type = rfc_sap_return.value[TYPE].strip
    @id = rfc_sap_return.value[ID].strip
    @number = rfc_sap_return.value[NR]
    @message = rfc_sap_return.value[MSG].strip
    @message_v1 = rfc_sap_return.value[MSGV1].strip
    @message_v2 = rfc_sap_return.value[MSGV2].strip
    @message_v3 = rfc_sap_return.value[MSGV3].strip
    @message_v4 = rfc_sap_return.value[MSGV4].strip
    @rfc_name = function.name

    if rfc_sap_return.value[APP_SERVER]
      @app_server = rfc_sap_return.value[APP_SERVER].strip
    end

    @sap_time = calculate_rfc_time(rfc_sap_return.value[START_TIME], rfc_sap_return.value[END_TIME])
    @standard_time = rfc_sap_return.value[STANDARD_TIME]
  end

  def overflow?
    @message&.to_sym == OVERFLOW
  end

  private

  def calculate_rfc_time(from, to)
    default = 1

    SAP_TIME_CALCULATION_RANGES.each do |factor, range|
      default += sap_time_diff(to[range], from[range], factor)
    end

    default
  end

  def sap_time_diff(to, from, factor)
    (to.to_i - from.to_i) * factor
  end
end
