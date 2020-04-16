module CorevistAPI
  class RFCServices::PartnerSearchRFC < RFCServices::BaseRFCService
    KEY_NAME = 'NAME'.freeze
    KEY_CITY = 'CITY'.freeze
    KEY_FCT = 'FCT'.freeze
    KEY_POSTAL_CODE = 'POSTAL_CODE'.freeze
    KEY_NR = 'NR'.freeze
    KEY_MAX_RESULTS = 'MAX_RESULTS'.freeze
    VALUE_FCT = 'AG'.freeze
    VALUE_MAX_RESULTS = '100'.freeze

    protected

    def function_name
      :partner_search
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge(rfc_user))
    end

    def output
      super

      @data[:partners] = get_function_param(PARTNER_LIST).map do |partner|
        RfcResultEntry.new(self.class.name.demodulize.underscore, partner)
      end
    end

    def object_to_rfc
      {
        SEARCH_CRITERIA => {
          KEY_NAME => @object.instance_variable_get(:@name).to_s.to_sap_search_string(35),
          KEY_CITY => @object.instance_variable_get(:@city).to_s.to_sap_search_string(25),
          KEY_FCT => VALUE_FCT,
          KEY_POSTAL_CODE => @object.instance_variable_get(:@postal_code).to_s.to_sap_search_string(10),
          KEY_NR => @object.instance_variable_get(:@number).to_s.to_sap_search_string(10),
          KEY_MAX_RESULTS => VALUE_MAX_RESULTS
        }
      }
    end
  end
end
