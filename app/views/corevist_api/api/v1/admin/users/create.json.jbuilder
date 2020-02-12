json.user do
  json.call(@result.data, *@result.data.attributes.keys)
  json.roles @result.data.roles
  json.assignable_roles @result.data.assignable_roles
  json.partners @result.data.partners
  json.territories @result.data.microsite.territories
end
