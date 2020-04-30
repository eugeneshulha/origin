module CorevistAPI
  module Services
    class Admin::Users::Step6CreationService< CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        raise CorevistAPI::ServiceException.new(not_found_msg) unless user
        return result(user) if @form.territory_ids.blank?

        territories = @form.territory_ids&.each_with_object([]) do |territory_id, memo|
          territory = CorevistAPI::Territory.find_by_id(territory_id)
          raise CorevistAPI::ServiceException.new("api.errors.#{namespace}.territories.not_found") unless territory

          memo << territory
        end

        user.microsite.territories = territories
        result(user)
      end
    end
  end
end
