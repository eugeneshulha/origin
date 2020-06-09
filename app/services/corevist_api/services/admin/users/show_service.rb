module CorevistAPI::Services::Admin::Users
  class ShowService < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      object = object_class.find_by(uuid: @form.uuid)

      raise CorevistAPI::ServiceException.new(not_found_msg) unless object

      object.reload
      # TODO: pagination here is temporary. It should return an object only.
      data = paginate(items: [object])
      result(data)
    end

    def object_class
      CorevistAPI::User
    end
  end
end
