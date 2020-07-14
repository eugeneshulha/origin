module CorevistAPI::Services::Carts
  class UpdateService < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      object = CorevistAPI::Cart.find_by(uuid: @form.uuid)
      raise CorevistAPI::ServiceException.new(not_found_msg) unless object

      @rfc_result = rfc_service_for(:salesdoc_create, object, @params).call

      result(@rfc_result.data)
    end
  end
end
