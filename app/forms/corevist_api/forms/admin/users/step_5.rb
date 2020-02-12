#
# assigned ship tos
#
module CorevistAPI
  module Forms::Admin::Users
    class Step5 < BaseStep
      include CorevistAPI::FormValidations

      validate_form
    end
  end
end
