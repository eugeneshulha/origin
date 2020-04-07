module CorevistAPI
  class API::V1::SessionsController < Devise::SessionsController
    include CorevistAPI::Factories::FactoryInterface
    include CorevistAPI::ConfigsFor
    include JsonResponse

    configs_for :new

    def create
      @form = form_for(:sessions_create, params)

      if @form.valid?
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        success('devise.sessions.signed_in', account_id: resource.uuid)
      end
    end
  end
end
