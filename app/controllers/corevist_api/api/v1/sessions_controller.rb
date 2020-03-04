module CorevistAPI
  class API::V1::SessionsController < Devise::SessionsController
    include CorevistAPI::Factories::FactoryInterface
    include JsonResponse

    def new
      @result = service_for(:page_configs_read, :login).call
    end

    def create
      @form = form_for(:login, params)

      if @form.valid?
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        success('devise.sessions.signed_in', account_id: resource.uuid)
      end
    end
  end
end
