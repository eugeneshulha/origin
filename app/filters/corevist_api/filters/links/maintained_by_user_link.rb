module CorevistAPI
  module Filters::Links
    class MaintainedByUserLink < BaseLink
      def perform(data)
        return unless data.params.extract!(:maintained_by_user)

        data.query = data.query.where(['created_by = ? or updated_by = ?', data.object.username, data.object.username])
      end
    end
  end
end
