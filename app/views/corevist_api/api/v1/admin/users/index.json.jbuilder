users_json = @users.map { |user| user.as_json.merge(roles: user.roles, partners: user.partners) }

json.users do
  json.merge! users_json
end
