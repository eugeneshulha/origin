module CorevistAPI
  class RFCServices::OpenItemsRFC < CorevistAPI::RFCServices::BaseRFCService
    PAYER_NR = 'PAYER_NR'.freeze
    OPEN_ITEMS = 'OPEN_ITEMS'.freeze
    ACCOUNTING_DATA = 'ACCOUNTING_DATA'.freeze

    def function_name
      :open_items
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge(rfc_user))
    end

    def output
      super
      @data[:open_items] = get_function_param(OPEN_ITEMS).map do |open_item|
        RfcResultEntry.new(self.class.name.demodulize.underscore, open_item)
      end
      @data[:accounting_data] =  RfcResultEntry.new(nil, get_function_param(ACCOUNTING_DATA))
    end

    def object_to_rfc
      {
        COMP_CODE => @object.instance_variable_get(:@comp_code).to_s,
        PAYER_NR => payer_number
      }
    end

    private

    def payer_number
      (@object.instance_variable_get(:@payer_number) || user.payers.first&.number).add_leading_zeros
    end
  end
end
