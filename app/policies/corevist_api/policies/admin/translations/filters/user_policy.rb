module CorevistAPI
  module Policies::Admin
    module Translations
      class Filters::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
        def new?
          true
        end
      end
    end
  end
end
