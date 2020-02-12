module CorevistAPI
  class API::V1::BaseController < CorevistAPI::API::BaseController
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      error('api.errors.unauthorized')
    end

    def form_for(type, *params)
      CorevistAPI::Factories::FormsFactory.instance.for(type, *params)
    end

    def service_for(type, *params)
      CorevistAPI::Factories::ServicesFactory.instance.for(type, *params)
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
  end
end
