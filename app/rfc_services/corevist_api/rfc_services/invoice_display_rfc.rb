module CorevistAPI
  class RFCServices::InvoiceDisplayRFC < CorevistAPI::RFCServices::BaseRFCService
    def initialize(*)
      super
    end

    private

    def function_name
      :invoice_display
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(CorevistAPI::Context.current_user)
      set_params(rfc_object.merge(rfc_user))
    end

    def object_to_rfc
      { DOC_NR => @params[:doc_number].add_leading_zeros }
    end

    def output
      super

      @function.parameters.each_key do |key|
        value = @function.parameters[key].value
        next if value.blank?
        value = { key => value } if value.is_a?(String)

        @data[key.downcase] = value.map do |data|
          data = Hash[*data] if data.is_a?(Array)

          RfcResultEntry.new(self.class.name.demodulize.underscore, data)
        end
      end
    end
  end
end
