module CorevistAPI
  module Policies::Admin
    module Translations
      class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
        def index?
          user.authorized_for?('translation_maintenance')
        end

        def index_configs?
          true
        end

        def create?
          user.authorized_for?('translation_maintenance')
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
