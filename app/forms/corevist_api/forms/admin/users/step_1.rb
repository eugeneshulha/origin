#
# user details
#
module CorevistAPI
  module Forms::Admin::Users
    class Step1 < BaseStep
      include CorevistAPI::FormValidations

      UUID_KEY = 'uuid'.freeze

      def rejected_keys
        super << UUID_KEY
      end
    end
  end
end
