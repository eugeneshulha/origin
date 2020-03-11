json.status 200
json.data do
  json.items do
    json.array! @result.data
  end
end
