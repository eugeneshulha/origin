module CorevistAPI
  module Forms
    class Admin::Users::IndexForm < BaseForm
      include CorevistAPI::FormValidations

      def permitted_params
        %w[filters]
      end
    end
  end
end
