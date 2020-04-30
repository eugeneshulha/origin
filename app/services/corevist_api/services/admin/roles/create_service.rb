module CorevistAPI
  module Services
    module Admin::Roles
      class CreateService < CorevistAPI::Services::BaseServiceWithForm
        private

        def perform
          object = CorevistAPI::Role.new
          raise CorevistAPI::ServiceException.new(not_found_msg) unless object

          fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
          object.created_by = object.updated_by = current_user.id

          raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

          result(object)
        end
      end
    end
  end
end
