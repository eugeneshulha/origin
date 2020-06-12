module CorevistAPI::Services::Carts
  class CreateService < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      @rfc_result = rfc_service_for(:salesdoc_create, @form, @params.merge!(create: true)).call

      result(@rfc_result.data)
    end
  end
end
