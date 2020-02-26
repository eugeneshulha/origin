module CorevistAPI
  module Services
    class Admin::Roles::CreateService < BaseServiceWithForm
      def perform
        object = CorevistAPI::Role.find_by_id(@form.id) || CorevistAPI::Role.new
        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        object.created_by = object.updated_by = current_user.id

        return result.fail!(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
