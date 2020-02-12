if @result.successful?
  json.partners @result.data
else
  json.partial! 'corevist_api/api/common/errors', errors: @result.errors
end
