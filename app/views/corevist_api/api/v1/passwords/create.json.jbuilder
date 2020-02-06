if @is_sent
  json.status 200
  json.message 'Rest password instructions successfully sent'
else
  json.status 500
  json.message 'Error. Email was not sent. Please contact your administrator.'
end
