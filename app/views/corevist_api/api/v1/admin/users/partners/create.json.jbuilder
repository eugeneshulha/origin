if @result.success?
  json.partners @result.data[:partners].each do |partner|
    json.number partner.number
    json.function partner.function
    json.name partner.name
    json.state partner.state
    json.country partner.country
    json.city partner.city
    json.house partner.house
    json.postal_code partner.postal_code
    json.email partner.email
    json.partner_type partner.partner_type
    json.language partner.language
    json.payment_terms partner.payment_terms
    json.postal_address_1 partner.postal_address_1
    json.postal_address_2 partner.postal_address_2
    json.postal_address_3 partner.postal_address_3
    json.street_address_1 partner.street_address_1
    json.street_address_2 partner.street_address_2
    json.street_address_3 partner.street_address_3
    json.deleted partner.deleted
    json.assigned partner.assigned
    json.default partner.default
    json.function partner.function
    json.number partner.number
    json.name partner.name
  end
else
  json.partial! 'corevist_api/api/common/errors', errors: @result.errors
end
