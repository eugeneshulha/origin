module CorevistAPI
  module Policies
    module Partners::Filters
      class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
        def index_configs?
          true
        end

        def new?
          index?
        end
      end
    end
  end
end
