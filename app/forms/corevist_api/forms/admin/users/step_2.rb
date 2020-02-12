#
# assigned roles
#
module CorevistAPI
  module Forms::Admin::Users
    class Step2 < BaseStep
      include CorevistAPI::FormValidations

      validate_form
    end
  end
end
