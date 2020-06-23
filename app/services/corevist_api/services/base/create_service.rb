module CorevistAPI::Services::Base
  class CreateService < CorevistAPI::Services::BaseServiceWithForm

    def perform
      object = object_class.new
      raise CorevistAPI::ServiceException.new(not_found_msg) unless object

      fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }

      raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

      result(object)
    end
  end
end
