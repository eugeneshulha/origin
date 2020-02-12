#
# assigned sold tos
#
module CorevistAPI
  module Forms::Admin::Users
    class Step4 < BaseStep
      include CorevistAPI::FormValidations

      validate_form
    end
  end
end
