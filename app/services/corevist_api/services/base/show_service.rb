module CorevistAPI
  module Services
    class Base::ShowService< CorevistAPI::Services::BaseServiceWithForm

      def perform
        object = object_class.find_by_id(@form.uuid)

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        data = paginate(items: [object])
        result(data)
      end
    end
  end
end
