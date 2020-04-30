module CorevistAPI
  module Services
    module Admin::Users
      class DestroyService < CorevistAPI::Services::BaseServiceWithForm
        private

        def perform
          object = object_class.find_by(uuid: @form.uuid)

          raise CorevistAPI::ServiceException.new(not_found_msg) unless object

          object.destroy
          raise CorevistAPI::ServiceException.new(failed_destroy_msg) unless object.destroyed?

          result(object)
        end

        def object_class
          CorevistAPI::User
        end
      end
    end
  end
end
