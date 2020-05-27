module CorevistAPI
  module Services::Admin::SystemSettings::Microsites
    class UpdateService < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        object = object_class.find_by(id: @form.uuid)
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        object.sales_areas = CorevistAPI::SalesArea.where(id: @form.sales_areas) if @form.sales_areas.present?
        object.updated_by = current_user.id

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end

      def object_class
        CorevistAPI::Microsite
      end
    end
  end
end
