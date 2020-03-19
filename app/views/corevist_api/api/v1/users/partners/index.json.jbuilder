json.status 200
json.data do
  json.partners do
    json.array! @partners
  end
end
