users_json = @users.map { |user| user.as_json.merge(roles: user.roles, assigned_partners: user.assigned_partners) }

json.users do
  json.merge! users_json
end
