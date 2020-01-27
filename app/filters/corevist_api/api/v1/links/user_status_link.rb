module CorevistAPI
  module API::V1::Filters::Links
    class UserStatusLink < BaseLink
      INCOMPLETE = 'incomplete'.freeze
      INACTIVE = 'inactive'.freeze
      USER_STATUSES = [INCOMPLETE, INACTIVE].freeze
      DB_USER_STATUSES_MAP = {
        INCOMPLETE => { complete: false },
        INACTIVE => { active: false }
      }.freeze

      def perform(data)
        return unless data.params.exists?(:user_status) && allow_to_search?(data)

        data.query = data.query.where(users: DB_USER_STATUSES_MAP[data.params.extract!(:user_status)])
      end

      private

      def allow_to_search?(data)
        USER_STATUSES.include?(data.params.get(:user_status))
      end
    end
  end
end
