json.role do
  json.merge! @role.as_json.merge(sales_areas: @role.sales_areas, users: @role.users)
end
