if @is_sent
  json.status 200
  json.message 'Reset password instructions successfully sent'
else
  json.status 500
  json.message 'Error. Email was not sent. Please contact your administrator.'
end
