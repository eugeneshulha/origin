module CorevistAPI::Services::Admin::Translations
  class CreateService < CorevistAPI::Services::BaseServiceWithForm
    def perform
      object = CorevistAPI::Translation.new

      fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
      object.updated_by = current_user.id

      raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

      result(object)
    end
  end
end
