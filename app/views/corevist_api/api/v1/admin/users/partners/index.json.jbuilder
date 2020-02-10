json.partners @collection.each do |partner|
  json.partial! 'corevist_api/api/v1/admin/users/partners/entry', entry: partner
end
