module CorevistAPI
  module Services::Admin::Users
    class Step5CreationService < Step4CreationService
      private

      def perform
        raise CorevistAPI::ServiceException.new(not_found_msg) unless user

        assigned_partners = user.assigned_partners.where(function: function_name(excluded_function))
        return result(user) if @form.partners.blank? && assigned_partners.present?

        raise CorevistAPI::ServiceException.new("api.errors.#{namespace}.one_function") if assigned_partners.present?
        raise CorevistAPI::ServiceException.new("api.errors.#{namespace}.at_least_one_function") if assigned_partners.blank? && @form.partners.blank?

        process_partners
      end

      def function
        :sh
      end

      def excluded_function
        :sp
      end
    end
  end
end
