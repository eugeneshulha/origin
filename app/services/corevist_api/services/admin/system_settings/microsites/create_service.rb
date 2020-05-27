module CorevistAPI
  module Services::Admin::SystemSettings::Microsites
    class CreateService < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        object = CorevistAPI::Microsite.new
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        object.sales_areas = CorevistAPI::SalesArea.where(id: @form.sales_areas) if @form.sales_areas.present?
        object.created_by = object.updated_by = current_user.id

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
