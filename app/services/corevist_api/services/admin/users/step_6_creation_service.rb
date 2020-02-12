module CorevistAPI
  module Services
    class Admin::Users::Step6CreationService < BaseServiceWithForm
      def perform
        return result.fail!('api.errors.user_not_found') unless user

        @form.territories_ids.each do |territory_id|
          territory = CorevistAPI::Territory.find_by_id(territory_id)
          return result.fail!('api.errors.territory_not_found') unless territory

          user.microsite.territories << territory
        end

        return result.fail!(user.errors.full_messages) if result.failed?

        result(user)
      end
    end
  end
end
