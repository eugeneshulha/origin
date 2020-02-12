module CorevistAPI
  module Services
    class Admin::Users::Step1CreationService < BaseServiceWithForm
      def perform
        object = CorevistAPI::User.find_by_uuid(@form.uuid) || CorevistAPI::User.new
        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        return result.fail!(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
