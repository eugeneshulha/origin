module CorevistAPI
  module Services
    module Admin::Users::Partners
      class IndexService < CorevistAPI::Services::BaseServiceWithForm
        def perform
          u = CorevistAPI::User.find_by(uuid: @form.user_uuid)
          raise CorevistAPI::ServiceException.new('api.errors.users.not_found') unless u

          partners = u.partners.where(function: @form.function, assigned: true)

          data = paginate(items: partners)
          result(data)
        end
      end
    end
  end
end
