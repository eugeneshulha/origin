module CorevistAPI
  module Policies::Admin
    module Users::Filters
      class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
        def new?
          true
        end
      end
    end
  end
end
