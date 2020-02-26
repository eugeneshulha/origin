module CorevistAPI
  module Forms
    class Admin::Roles::ShowForm < BaseForm
      include CorevistAPI::FormValidations

      def permitted_params
        %w[id]
      end
    end
  end
end
