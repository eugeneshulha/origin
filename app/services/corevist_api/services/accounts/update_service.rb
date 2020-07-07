module CorevistAPI::Services::Accounts
  class UpdateService < CorevistAPI::Services::Base::UpdateService
    def perform
      object = object_class.find_by(uuid: @form.uuid)
      raise CorevistAPI::ServiceException.new(not_found_msg) unless object

      fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
      return result(object, message: did_not_change) unless object.changed?

      raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

      result(object)
    end

    private

    def object_class
      CorevistAPI::User
    end
  end
end
