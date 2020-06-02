module CorevistAPI::Policies::Admin::SystemSettings::DocCategories
  class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
    def index?
      true
    end
  end
end
