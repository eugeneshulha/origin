module CorevistAPI
  module Filters
    class UserFilter < BaseFilter
      chain << :user_classification_link << :user_status_link << :role_id_link << :assigned_partner_link <<
        :maintained_by_user_link << :criteria_link << :assigned_partner_or_partners_link << :user_type_link <<
        :microsite_link << :partners_link << :order_link

      def initialize(*args)
        @result = CorevistAPI::Filters::Results::UserResult.new(*args)
      end
    end
  end
end
