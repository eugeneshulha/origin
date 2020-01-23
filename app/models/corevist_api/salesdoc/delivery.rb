module CorevistAPI
  class Salesdoc::Delivery
    attr_accessor :number, :delivery_date, :gi_date, :tracking_number, :carrier_number, :carrier_name,
                  :postal_address, :street_address, :tracking_numbers, :shipment
  end
end
