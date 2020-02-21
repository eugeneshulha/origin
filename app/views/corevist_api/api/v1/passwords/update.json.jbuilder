if @form.errors.empty?
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
      errors: @form.errors.full_messages
  }

  json.merge!(h)
end
