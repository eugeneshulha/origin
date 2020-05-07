module CorevistAPI
  class API::V1::SessionsController < Devise::SessionsController
    include CorevistAPI::Factories::FactoryInterface
    include CorevistAPI::ConfigsFor
    include JsonResponse

    configs_for new: { authorize: false }

    def create
      form = form_for(:sessions_create, params)
      service = service_for(:login, form, self)
      result = service.call

      success(message, account_id: result&.data&.uuid)
    end
  end
end
