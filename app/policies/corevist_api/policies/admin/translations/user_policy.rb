module CorevistAPI
  module Policies::Admin
    module Translations
      class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
        def index?
          user.authorized_for?('translation_maintenance')
        end

        def index_configs?
          index?
        end

        def create?
          index?
        end

        def destroy?
          index?
        end

        def update?
          index?
        end

        def download?
          index?
        end
      end
    end
  end
end
