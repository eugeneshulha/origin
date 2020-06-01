module CorevistAPI::Policies::Admin::SystemSettings::DocTypes
  class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
    def index?
      true
    end

    def create?
      index?
    end

    def update?
      index?
    end

    def destroy?
      index?
    end
  end
end
