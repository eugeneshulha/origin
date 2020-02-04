if @user.destroyed?
  json.status :success
else
  json.errors @user.errors.full_messages
end
