if @result.successful?
  json.status 200
  json.messages [
                    "Thank you for registration request. You will receive an acknowledgement email soon."
                ]
else
  json.status 400
  json.errors [
                @result.errors.full_messages
              ]
end

