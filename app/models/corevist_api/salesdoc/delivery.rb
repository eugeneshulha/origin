module CorevistAPI
  class Salesdoc
    class Delivery
      include CorevistAPI::FormatConversion

      attr_accessor :number, :delivery_date, :gi_date, :tracking_number, :carrier_number, :carrier_name,
                    :tracking_numbers, :shipment, :status,
                    :street_address_1, :street_address_2, :street_address_3,
                    :postal_address_1, :postal_address_2, :postal_address_3

      format_date :delivery_date, :gi_date
    end
  end
end
