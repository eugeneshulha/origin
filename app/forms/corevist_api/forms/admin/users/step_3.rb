#
# roles user can assign
#
module CorevistAPI
  module Forms::Admin::Users
    class Step3 < BaseStep
      include CorevistAPI::FormValidations

      validate_form
    end
  end
end
