module CorevistAPI::Services::Base
  class DestroyService < CorevistAPI::Services::BaseService
    private

    def perform
      object = object_class.find_by(id: @params[:uuid])

      raise CorevistAPI::ServiceException.new(not_found_msg) unless object

      object.destroy
      raise CorevistAPI::ServiceException.new(failed_destroy_msg) unless object.destroyed?

      result(object)
    end
  end
end
