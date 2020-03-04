if result.successful?
  json.status 200
  json.data do
    json.configs result.data
  end
else
  json.status 500
  json.errors [
                  result.errors
              ]
end
