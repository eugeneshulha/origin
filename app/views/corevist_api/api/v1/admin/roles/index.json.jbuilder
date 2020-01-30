roles_json = @roles.map { |role| role.as_json.merge(sales_areas: role.sales_areas, users: role.users) }

json.roles do
  json.merge! roles_json
end
