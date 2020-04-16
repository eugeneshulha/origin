module CorevistAPI
  module Services
    module Admin::Users
      module Partners
        class DestroyService< CorevistAPI::Services::BaseServiceWithForm
          def perform
            u = CorevistAPI::User.find_by(uuid: @form.user_uuid)
            raise CorevistAPI::ServiceException.new('api.errors.users.not_found') unless u

            partner = u.partners.find_by(function: @form.function, number: @form.number, assigned: true)
            raise CorevistAPI::ServiceException.new('api.errors.users.partners.not_found') unless partner

            partner.destroy
            result(u)
          end
        end
      end
    end
  end
end
