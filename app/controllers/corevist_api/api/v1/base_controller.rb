module CorevistAPI
  class API::V1::BaseController < CorevistAPI::API::BaseController
    include CorevistAPI::Factories::FactoryInterface
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def authenticate_user!(opts={})
      opts[:scope] = :user
      user_not_authorized unless warden.authenticate(opts)
    end

    def user_not_authorized
      error_401('api.errors.unauthorized')
    end

    def policy_class(klass, scope = false)
      "#{self.class.name.remove(/Controller/)}::#{klass.name.demodulize}Policy#{'::Scope' if scope}".safe_constantize
    end

    def policy_scope(scope, policy_scope_class: nil)
      super(scope, policy_scope_class: policy_scope_class || policy_class(scope.model_name.name.safe_constantize, true))
    end

    def authorize(record, query = nil, policy_class: nil)
      super(record, query, policy_class: policy_class || policy_class(record.model_name))
    end

    def authorize_user
      authorize(User)
    end
  end
end
