module CorevistAPI
  module API::V1::Filters::Links
    class UserTypeLink < BaseLink
      TYPE_CUSTOMER = 'customer'.freeze

      def perform(data)
        return unless data.object.customer_admin?

        data.query = data.query.where(user_type: TYPE_CUSTOMER)
      end
    end
  end
end
