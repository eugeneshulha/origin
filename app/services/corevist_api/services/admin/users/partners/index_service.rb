module CorevistAPI
  module Services
    module Admin::Users::Partners
      class IndexService < CorevistAPI::Services::BaseServiceWithForm
        private

        def perform
          u = CorevistAPI::User.find_by(uuid: @form.user_uuid)
          raise CorevistAPI::ServiceException.new('api.errors.users.not_found') unless u

          partners = u.partners.where(function: @form.function, assigned: true)

          items = filter_by_query(partners)
          items = sort_by_param(items)

          data = paginate(items: items)
          result(data)
        end
      end
    end
  end
end
