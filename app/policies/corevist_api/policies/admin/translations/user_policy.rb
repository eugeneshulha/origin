module CorevistAPI
  module Policies::Admin
    module Translations
      class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
        def index?
          true
        end

        def index_configs?
          true
        end

        def create?
          true
        end

        def destroy?
          create?
        end

        def update?
          create?
        end
      end
    end
  end
end
