if resource.errors.empty?
  h = {
      status: 200,
      messages: [
          "New password successfully set"
      ]
  }
  json.merge!(h)
else
  h = {
      status: 500,
      errors: resource.errors
  }

  json.merge!(h)
end