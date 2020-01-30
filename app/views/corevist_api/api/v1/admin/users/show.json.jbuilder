json.user do
  json.merge! @user.as_json.merge(roles: @user.roles)
end
