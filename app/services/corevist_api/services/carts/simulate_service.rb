module CorevistAPI::Services::Carts
  class SimulateService < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      @rfc_result = rfc_service_for(:salesdoc_create, @form, @params).call

      result(@rfc_result.data)
    end
  end
end
