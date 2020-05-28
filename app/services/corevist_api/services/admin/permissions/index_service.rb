module CorevistAPI
  module Services::Admin::Permissions
    class IndexService < CorevistAPI::Services::Base::IndexService
      private

      def filter
        result(
          if @params['role_id'].present?
            CorevistAPI::Role.find_by_id(@params['role_id']).permissions_list
          else
            CorevistAPI::Permission.all
          end
        )
      end
    end
  end
end
