module CorevistAPI::Policies::Admin::Translations::Filters
  class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
    def new?
      true
    end
  end
end
