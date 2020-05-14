module CorevistAPI
  module Services
    module Admin::Users::Partners
      class IndexService < CorevistAPI::Services::BaseServiceWithForm
        private

        def perform
          user = CorevistAPI::User.find_by(uuid: @form.user_uuid)
          raise CorevistAPI::ServiceException.new('api.errors.users.not_found') unless user

          query = if @form.parent_partner.blank?
                    { function: @form.function, assigned: true }
                  else
                    { function: @form.function, parent_partner: @form.parent_partner }
                  end

          partners = user.partners.where(query)

          items = filter_by_query(partners)
          items = sort_by_param(items)

          data = paginate(items: items)
          result(data)
        end
      end
    end
  end
end
