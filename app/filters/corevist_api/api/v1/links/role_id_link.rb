module CorevistAPI
  module API::V1::Filters::Links
    class RoleIdLink < BaseLink
      def perform(data)
        return unless data.params.exists?(:role_id)

        data.query = data.query.joins(:roles).where(roles: { id: data.params.extract!(:role_id) })
      end
    end
  end
end
