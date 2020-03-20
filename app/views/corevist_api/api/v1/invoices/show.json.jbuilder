json.status 200
price_components = {
    title: "Pricing details",
    content_type: 'table',
    data: @result.data['price_components'].map do |pc|
      { title: "label for #{pc['cond_type']}", text: pc['value'] }
    end
}

partners = @result.data['partners'].map do |partner|
  { title: "Partner #{partner['function']}", text: "#{partner['street_address_1']}, #{partner['street_address_2']}, #{partner['street_address_3']}" }
end

doc_details = {
    title: "title for invoice",
    data: [
        *partners,
        { title: 'Sales Area', text: @result.data['header']['sales_area'] },
        { title: 'Doc type', text: @result.data['header']['doc_type'] }

    ]
}

json.data [
              price_components,
              doc_details
          ]
