module CorevistAPI
  class Partner < CorevistAPI::BasicPartner
    attr_accessor :postal_address, :street_address, :sales_data, :sap_return, :functions, :state, :country,
                  :address_number, :language, :texts, :email_address, :ptype
  end
end
