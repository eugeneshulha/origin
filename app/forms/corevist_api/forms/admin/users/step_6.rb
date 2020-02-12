#
# assigned territories
#
module CorevistAPI
  module Forms::Admin::Users
    class Step6 < BaseStep
      include CorevistAPI::FormValidations

      validate_form
    end
  end
end
