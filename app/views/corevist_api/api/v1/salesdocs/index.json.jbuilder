if request.get?
  json.partial! 'corevist_api/api/v1/shared/configs', result: @result
else
  json.status 200
  json.data @result.data
end
