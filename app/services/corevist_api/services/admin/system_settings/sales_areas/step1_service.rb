module CorevistAPI::Services::Admin::SystemSettings::SalesAreas
  class Step1Service < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      object = CorevistAPI::SalesArea.find_by(title: @form&.title) || CorevistAPI::SalesArea.new
      fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)&.strip) }
      raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

      result(object)
    end

    def object_class
      CorevistAPI::SalesArea
    end
  end
end
