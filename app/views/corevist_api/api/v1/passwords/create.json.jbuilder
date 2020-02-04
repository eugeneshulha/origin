if @is_sent
  json.status :success
  json.message 'Rest password instructions successfully sent'
else
  json.status :error
  json.message 'Something went wrong with sending an email'
end
