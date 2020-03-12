json.status 200
price_components = {}
price_components[:data] = @result.data['price_components'].map do |pc|
  { title: "label for #{pc['cond_type']}", text: pc['value'] }
end
price_components[:title] = "Pricing details"
json.data [
              price_components
          ]
