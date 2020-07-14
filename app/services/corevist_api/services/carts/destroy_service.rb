module CorevistAPI::Services::Carts
  class DestroyService < CorevistAPI::Services::BaseService
    private

    def perform
      object = CorevistAPI::Cart.find_by(uuid: @params[:uuid])

      raise CorevistAPI::ServiceException.new(not_found_msg) unless object

      object.destroy
      raise CorevistAPI::ServiceException.new(failed_destroy_msg) unless object.destroyed?

      result(object)
    end
  end
end
