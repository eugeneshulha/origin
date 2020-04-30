module CorevistAPI
  module Services
    class Admin::Roles::ShowService < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        object = object_class.find_by(id: @form.uuid)

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        # TODO: pagination here is temporary. It should return an object only.
        data = paginate(items: [object])
        result(data)
      end

      def object_class
        CorevistAPI::Role
      end
    end
  end
end
