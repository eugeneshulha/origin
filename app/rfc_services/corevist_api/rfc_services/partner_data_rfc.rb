module CorevistAPI
  class RFCServices::PartnerDataRFC < CorevistAPI::RFCServices::BaseRFCService
    protected

    def function_name
      :get_partner
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge(rfc_user))
    end

    def output
      super
      partner_number = get_function_param(PARTNER_NUMBER).strip

      partner = get_function_param(PARTNERS).find { |partner| partner[NR] == partner_number }
      @data[:partner] = RfcResultEntry.new(self.class.name.demodulize.underscore, partner)

      partner_sales_data = get_function_param(PARTNERS_SALES_DATA).select { |data| data[NR] = partner_number }
      @data[:partner_sales_data] = partner_sales_data.map do |data|
        RfcResultEntry.new(self.class.name.demodulize.underscore, data)
      end

      postal_addresses = get_function_param(POSTAL_ADDRESSES).select { |data| data[NR] = partner_number }
      @data[:postal_addresses] = postal_addresses.map do |postal_address|
        RfcResultEntry.new(self.class.name.demodulize.underscore, postal_address)
      end

      street_addresses = get_function_param(STREET_ADDRESSES).select { |data| data[NR] = partner_number }
      @data[:street_addresses] = street_addresses.map do |street_address|
        RfcResultEntry.new(self.class.name.demodulize.underscore, street_address)
      end
    end

    def object_to_rfc
      {
        PARTNER_NUMBER => @object.partner_number.to_s
      }
    end
  end
end
