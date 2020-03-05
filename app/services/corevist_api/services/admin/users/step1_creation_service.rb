module CorevistAPI
  module Services
    class Admin::Users::Step1CreationService < BaseServiceWithForm
      def perform
        object = obtain_object
        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end

      private

      def obtain_object
        CorevistAPI::User.new
      end
    end
  end
end
