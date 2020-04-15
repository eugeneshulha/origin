module CorevistAPI
  module Services
    class Base::ShowService< CorevistAPI::Services::BaseServiceWithForm

      def perform
        object = object_class.find_by_id(@form.uuid)

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        # TODO: pagination here is temporary. It should return an object only.
        data = paginate(items: [object])
        result(data)
      end
    end
  end
end
