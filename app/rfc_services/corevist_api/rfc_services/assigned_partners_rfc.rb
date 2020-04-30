module CorevistAPI
  class RFCServices::AssignedPartnersRFC < CorevistAPI::RFCServices::BaseRFCService
    protected

    def function_name
      :assigned_partners
    end

    def input
      rfc_user = user_to_rfc(user)
      set_params(rfc_user)
    end

    def output
      super

      partners = get_function_param(PARTNERS)
      @data[:partners] = partners.map do |data|
        RfcResultEntry.new(self.class.name.demodulize.underscore, data)
      end

      functions_partners = get_function_param(FUNCTIONS_PARTNERS)
      @data[:functions_partners] = functions_partners.map do |data|
        RfcResultEntry.new(self.class.name.demodulize.underscore, data)
      end

      assigned_sold_tos = get_function_param(ASSIGNED_SOLD_TOS)
      @data[:assigned_sold_tos] = assigned_sold_tos.map do |data|
        RfcResultEntry.new(self.class.name.demodulize.underscore, data)
      end

      assigned_ship_tos = get_function_param(ASSIGNED_SHIP_TOS)
      @data[:assigned_ship_tos] = assigned_ship_tos.map do |data|
        RfcResultEntry.new(self.class.name.demodulize.underscore, data)
      end

      assigned_payers = get_function_param(ASSIGNED_PAYERS)
      @data[:assigned_payers] = assigned_payers.map do |data|
        RfcResultEntry.new(self.class.name.demodulize.underscore, data)
      end

      partner_sales_data = get_function_param(PARTNERS_SALES_DATA)
      @data[:partner_sales_data] = partner_sales_data.map do |data|
        RfcResultEntry.new(self.class.name.demodulize.underscore, data)
      end

      postal_addresses = get_function_param(POSTAL_ADDRESSES)
      @data[:postal_addresses] = postal_addresses.map do |postal_address|
        RfcResultEntry.new(self.class.name.demodulize.underscore, postal_address)
      end

      street_addresses = get_function_param(STREET_ADDRESSES)
      @data[:street_addresses] = street_addresses.map do |street_address|
        RfcResultEntry.new(self.class.name.demodulize.underscore, street_address)
      end
    end
  end
end
