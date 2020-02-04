if @role.destroyed?
  json.status :success
else
  json.errors @role.errors.full_messages
end
